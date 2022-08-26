extends Node2D

var BulletScene = preload("res://src/GameMain/Guntret/Bullet_Area2D.tscn")
var EnemyLoopScene = preload("res://src/GameMain/Enemies/PathFollowEnemies.tscn")
var EnemyScene = preload("res://src/GameMain/Enemies/Enemy_Area2D.tscn")
var EnemyBulletScn = preload("res://src/GameMain/Enemies/EnemyBullet.tscn")

var EnemyExplode = preload("res://src/GameMain/Particle/RectParticle.tscn")

#----------------------------------------------------------------------------
#エネミーを隊列で並べる時のグリッド座標情報
var MatrixCol = 8
var MatrixRow = 5

class ENEMY_MATRIX:
	var Col : int
	var Row : int
	var WorldX : float
	var WorldY : float
	var State : int

var EnemyMatrix = []

func InitEnemyMatrix():
	var offsetX=64 + 8
	var offsetY=32 + 8
	var SPW = 16
	var SPH = 16
	
	#var ypos=0
	for y in MatrixRow:
		for x in MatrixCol:
			
			var WldX : float = offsetX + x * SPW
			var WldY : float = offsetY + y * SPH
			#EnemyMatrix.append({"Col":x, "Row":y, "WldX":WldX, "WldY":WldY})	
			var mtmp = ENEMY_MATRIX.new()
			mtmp.Col = x
			mtmp.Row = y
			mtmp.WorldX = WldX
			mtmp.WorldY = WldY
			
			EnemyMatrix.append(mtmp)

#配列Col,Rowから1次元配列インデックスを返す
func Pos2Index(var x , var y):
	return x + (MatrixCol * y)

#----------------------------------------------------------------------------
#エネミーを隊列で並べる時のグリッド座標情報

#画面上のエネミー管理リスト
var EnemyList = []	#スポーンしたエネミーのリスト　
var LoopSeqEnd = false #スタート出現時のループがすべて終了していればtrueになる　
	
var SeqTimerGbl = 0 #グローバルタイマ
var SeqTimerSec = 0	#シーンシーケンスの制御タイマ(1秒)
var SeqTimerFps = 0#フレーム
var SeqPtr = 0	#シーケンス参照ポインタ
var SeqEnable = false	#シーケンス実行中フラグ

#----------------------------------------------------------------------------
#エネミー出現シーケンス情報
var EnemySequence #実行中のシーケンス
var EnemySeqList = [] #実行するシーケンスの辞書リスト
var EnemySeqStageNum = 0	#実行中のステージ番号
#$EnemyScript.StateSeq01, $EnemyScript.StateSeq02]

#		{"Cmd" : "EnemyStrength", "Attack" : 4000, "Shot": 4000, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある
var EnemyAttackRate : int	#エネミーが攻撃耐性に入る確率
var EnemyShotRate : int	#エネミーが弾を撃ってくる確率
var EnemyShotAim : bool	#自機狙い弾を撃ってくるかどうか true/false

#----------------------------------------------------------------------------

var _GameOverTimer : float = 0.0

var FormationEnemyTimer = 0	#エネミーの隊列アニメタイマ

#自機のホームポジション
const GuntretHomePosX = GlobalNode.ScreenWidth / 2
const GuntretHomePosY = GlobalNode.ScreenHeight -32

#ステージクリアアニメーションのY速度
const DEFSTARSPEED = 5
var StageClearGuntret_SpdY = 10
var StageClearBgStarSpd = DEFSTARSPEED #default =5
var FlgStageClear = false

#debug
var debug_spawn = 0

#Frame Counter
var fps = 0
var EnemyAnimCnt = 0

#Display Shake
var DispShake = false
var DispShakeCount = 0
var DispShakeWidth = 10

var HighScoreCheck = false
#シーケンスパーサ
#SeqTimerタイマノードからから呼ばれてます
func SeqState():
	if SeqEnable==false:
		return
	
	var Seq
	
	if SeqPtr <= EnemySequence.size():
		Seq = EnemySequence[SeqPtr]
	else:
		print("Error:Swq Pointer OverRun!")
		return
	
	match Seq["Cmd"]:
		"Init_s":
			SeqTimerSec = 0	#シーンシーケンスの制御タイマ(1秒)
			SeqPtr+=1
		
		"Init_f":
			SeqTimerFps = 0
			SeqPtr+=1
		
		"Init_g":
			SeqTimerGbl = 0
			SeqPtr+=1
		
		"Wait_s":
			if SeqTimerSec == Seq["Time"]:
				#print("Sec Process ", Seq["Time"], "sec")
				SeqTimerSec=0
				SeqPtr+=1
		
		"Wait_f":
			if SeqTimerFps == Seq["Time"]:
				#print("Fps Process ", Seq["Time"], "Fps")
				SeqTimerFps=0
				SeqPtr+=1
			
		"Wait_g":
			if SeqTimerGbl == Seq["Time"]:
				#print("GrobalTime Process ", Seq["Time"], "Time")
				SeqPtr+=1

#		{"Cmd" : "EnemyStrength", "Attack" : 4000, "Shot": 4000, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある
		"EnemyStrength":
				EnemyAttackRate = Seq["Attack"]
				EnemyShotRate  = Seq["Shot"]
				EnemyShotAim  = Seq["Aim"]
				SeqPtr+=1
#		{"Cmd" : "EnemyStrength", "Attack" : 4000, "Shot": 4000, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある
#		var EnemyAttackRate	#エネミーが攻撃耐性に入る確率
#		var EnemyShotRate	#エネミーが弾を撃ってくる確率
#		var EnemyShotAim	#自機狙い弾を撃ってくるかどうか true/false
			
		
		"LoopEnmy":
			LoopEnemySpawn(Seq["LoopType"], Seq["Color"], Seq["Matrix"], Seq["Spd"])
			SeqPtr+=1
		
		"FormationFlg":
			GlobalNode.EnemyFormation = Seq["Flg"]
			FormationEnemyTimer = 0
			#print(GlobalNode.EnemyFormation)
			SeqPtr+=1
		
		"MsgStageStart":
			$CanvasStart.DrawParsec(Seq["Num"])
			$CanvasStart.visible = true
			GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_START
			
			GlobalNode.EnFrmState = GlobalNode.EnFrmStateID.STOP
			GlobalNode.BgScrollReverse = false
			GlobalNode.EnemyFormationAttack = false

			#GlobalNode.EnemyFormationFinished = false #すべてのエネミーがloop後にホームポジションに戻るとこのフラグがtrueになる
			
			SeqPtr+=1
		#{"Cmd" : "MsgStageStart", "Num" : 1},
		
		"BgStarScroll":
			#export var StarSpeed = 5 #小さくすると速くなるよ
			#export var StarDirection = 1 #-1にすると逆スクロールだよ　
			$BgColor/BackGroundStars.SetStarSpeed(Seq["Spd"], Seq["Dir"])
			
			#バックスクロール中のフラグ設定
			if Seq["Dir"] == 1:
				GlobalNode.BgScrollReverse = false
			elif Seq["Dir"] == -1:
				GlobalNode.BgScrollReverse = true
				
			SeqPtr+=1
		
		#エネミーのフォーメーション配置完了
		"EnmyFormationActive":
			GlobalNode.EnemyFormationFinished = Seq["Flg"] #エネミーのフォーメーション遷移　完了(trye)／未完了(false)　
			#print("Enemy Form Seq=", GlobalNode.EnemyFormationFinished)
			SeqPtr+=1

		#エネミーのフォーメーション配置完了
		"EnmyFormationAttack":
			GlobalNode.EnemyFormationAttack = Seq["Flg"] #エネミーのフォーメーション攻撃開始
			#print("Enemy Form Seq=", GlobalNode.EnemyFormationFinished)
			SeqPtr+=1
		
		#フォーメーションのアニメ開始／停止
		"EnmyFormationAnim":
			GlobalNode.EnFrmState = Seq["Flg"]
			SeqPtr+=1
			
		"End":
			#print("Sqe End")
			SeqEnable=false		#シーケンサ処理停止
			LoopSeqEnd = true	#出現ループ完了フラグOn
			
			#敵が0だったらステージクリアにする
			#バックスクロール面、ブロック崩し面、インベーダー面などでこの処理が走るはず　
			if EnemyList.size() == 0:
				StageClearGuntret_SpdY = 10
				GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_CLEAR
				$CanvasStageClear.visible = true

#--------------------------------------------
func LoopEnemySpawn(var LoopType : int, var EnemyColor : int, var Matrix:Vector2, var Speed:float) -> void:
	#print("GetSpd", Speed)
	#オブジェクト生成	
	var ScnLoop = EnemyLoopScene.instance()	#ループ
	var ScnEnemy = EnemyScene.instance()	#エネミー

	#エネミー生成------------------------------------------
	var enid = ScnEnemy.get_instance_id()
	ScnEnemy.SetEnemyId(enid)
	ScnEnemy.SetEnemyColor(EnemyColor)
	ScnEnemy.SetEnemyAttackRate(EnemyAttackRate, EnemyShotRate, EnemyShotAim)	
	ScnEnemy.SetEnemyState(GlobalNode.EnemyStateID.STAT_LOOP)
	
	#ここもっとスマートにかけない？
	var tmp :ENEMY_MATRIX =	EnemyMatrix[Pos2Index(Matrix.x, Matrix.y)]
	ScnEnemy.SetEnemyMatrix(Matrix, Vector2(tmp.WorldX, tmp.WorldY))
	add_child(ScnEnemy)
	
	#エネミー管理リストに追加
	AppendEnemy(ScnEnemy)
	#エネミー生成------------------------------------------
	
	#ループ生成-------------------------------------------
	var loopid = ScnLoop.get_instance_id()
	ScnLoop.InitLoopEnemies(ScnEnemy,loopid, LoopType)
	ScnLoop.SetUnifOffset(Speed)
	add_child(ScnLoop)
	#ループ生成-------------------------------------------

#エネミーの出現ループが完了するとこの関数がエネミー側から呼ばれる
func LoopEnemyOver(var EnemyId, var NowPos : Vector2, var ToPos : Vector2):
	
	#ループ処理が終わると終了したエネミーのオブジェクトIDが戻って売る
	if EnemyId.Alive == false:	#ループ処理から戻ってきたタイミングで破壊されていたらならエネミーのオブジェクトをガベコレ
		EnemyId.queue_free()
	else:
		#逆スクロール面のエネミーは画面外に出たら消す（インベーダー面、ブロック崩す面もこれ？）
		if GlobalNode.BgScrollReverse == true:
			EnemyList.pop_front()
			EnemyId.queue_free()
			return
		
		#ループ終了後、ホームポジションへ移動させる
		EnemyId.SetEnemyState(GlobalNode.EnemyStateID.STAT_GOHOME)
		
#エネミー管理リストへ追加
func AppendEnemy(var EnemyId):
		EnemyList.append(EnemyId)
	
#エネミー削除（エネミークラスからも呼ばれる）
#ステージクリア判定もここで行う　
func DeleteEnemy():
	EnemyList.pop_front()
	
	#活動中のエネミーがすべて破壊されていて、出現ループ処理が完了していればステージクリア処理
	if EnemyList.size() == 0 and LoopSeqEnd==true:
		#StageClear
		StageClearGuntret_SpdY = 10
		GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_CLEAR
		$CanvasStageClear.visible = true
		StageClearBgStarSpd=DEFSTARSPEED	#hoge


#エネミーからの弾発射依頼メッセージ
func ShotEnemyBullet(var EnemyPos : Vector2, var type):
	var ScnBullet = EnemyBulletScn.instance()
	add_child(ScnBullet)
	
	match type:
		0:#真下へ
			ScnBullet.SetPos(EnemyPos)
			ScnBullet.SetDegrees(90, 100) #90で真下ね　
		1:#直狙い、打ち返し
			ScnBullet.SetPos(EnemyPos)
			ScnBullet.SetToword($Guntret.position, 100)
		

#-------------------------------------------------------------		
#自機がやられると、この関数が呼ばれる
func GuntretCrush():
	
	#残機ゼロならゲームオーバー
	if 0 > $RestGuntret.DeleteGuntret():
		GlobalNode.GameState = GlobalNode.GState.GAMEOVER
		GlobalNode.SubState = GlobalNode.SUBSTATE.GAMEOVER
		
		#ステージ中音楽停止　
		$Sound/StartMusic.stop()
		$Sound/BackScroll.stop()
		
		yield(get_tree().create_timer(0.5) , "timeout")
		
		#ゲームオーバーサウンド再生、ゲームオーバー画面表示
		$Sound/GameOver.play()
		yield(get_tree().create_timer(0.5) , "timeout")
		$CanvasGameover.visible = true
		
#var Inv_Move = 0
#func Process_Invader():
		


#GameStartInit
func GameStartInit():
	#シーケンス実行開始
	#EnemySequence = $EnemyScript.StateSeq01	#実行するシーケンスの辞書リスト
	EnemySeqStageNum = 0
	EnemySequence = EnemySeqList[EnemySeqStageNum]
	SeqPtr=0
	SeqTimerFps=0
	SeqEnable = true
	FormationEnemyTimer = 0 #EnemyMoveTimer
	
	#Player Score Reset
	GlobalNode.PlayerScore = 0
	#HighScore = 0
	GlobalNode.GameTime = 0
	
	#自機のホームポジション
	$Guntret.position.x = GuntretHomePosX
	$Guntret.position.y = GuntretHomePosY
	
	FlgStageClear = false
	
	#シーケンス完了フラグを初期化
	LoopSeqEnd=false
	GlobalNode.EnemyFormationFinished = false
	
	#BGの星を初期化（バックスクロールしてたらここで戻る）
	#StageClearBgStarSpd=DEFSTARSPEED
	$BgColor/BackGroundStars.SetStarSpeed(DEFSTARSPEED,1)
	
	$Guntret.visible = true
	$RestGuntret.visible = true
	$CanvasScore.visible = true
	
	#残機 debug
#	$RestGuntret.SetRestGuntert(5)
	$RestGuntret.SetRestGuntert(2)
	
	#ゲーム中音楽開始　	
	$Sound/StartMusic.play()
#	$Sound/BackScroll.play()
	
	GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_START
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	InitEnemyMatrix()
	FormationEnemyTimer = 0

	#自機のホームポジション
	$Guntret.position.x = GuntretHomePosX
	$Guntret.position.y = GuntretHomePosY
	GlobalNode.GameMainSceneID = get_owner()
	
	#BGの星の移動速度設定
	#StageClearBgStarSpd=DEFSTARSPEED
	$BgColor/BackGroundStars.SetStarSpeed(DEFSTARSPEED,1)

	#-----------------------------------------------------------
	#シーケンスリスト作成（なんかスマートに書けないかな？）
#	EnemySeqList.append($EnemyScript.StateSeq01)
#	EnemySeqList.append($EnemyScript.StateSeq02)
#	EnemySeqList.append($EnemyScript.StateSeq03)
#	EnemySeqList.append($EnemyScript.StateSeq04)
	EnemySeqList.append($EnemyScript.StateSeq05)
	#-----------------------------------------------------------
	
	#ゲームステートシーケンス初期化	
	SeqPtr=0
	SeqTimerFps=0
	SeqEnable = true
	
	HighScoreCheck = false	#ゲームオーバー時のハイスコアチェックワンショットフラグ
	
	EnemyAnimCnt = 0	#エネミーの隊列アニメーション用フレームカウンタ


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$lblFps.text = "FPS:" + String(Engine.get_frames_per_second())
	
	#ゲームステートがプレイ中、ゲームオーバーの時いがいははじく
	if GlobalNode.GameState == GlobalNode.GState.TITLE:
		return
	
	GlobalNode.GameTime+=1
	
	#スコア表示　	
	var ScoreTxt= "Score:%010d" % GlobalNode.PlayerScore
	$CanvasScore/lblScore.text = ScoreTxt
	
	#実行ステート分岐　
	match GlobalNode.SubState:
		#Stage Start
		GlobalNode.SUBSTATE.STAGE_START:
#			StageClearBgStarSpd=DEFSTARSPEED	#hoge
#			$BgColor/BackGroundStars.SetStarSpeed(StageClearBgStarSpd,1)
			
			#StageClearBgStarSpd=DEFSTARSPEED	#hoge
			$BgColor/BackGroundStars.SetStarSpeed(DEFSTARSPEED,1)
			
			$Guntret.position = $Guntret.position.move_toward(Vector2(GuntretHomePosX, GuntretHomePosY), delta * 100)
			GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_PLAY
		
		#Play Gameing
		GlobalNode.SUBSTATE.STAGE_PLAY, GlobalNode.SUBSTATE.GAMEOVER:
			
			#if EnemySeqStageNum == 4:
			#if EnemySeqStageNum == 0:
				#print("Invador")
				#Process_Invader()
			
			#エネミーの左右移動アニメーション	
			#もちっとスマートに書けないか？
			if GlobalNode.EnFrmState != GlobalNode.EnFrmStateID.STOP:
				EnemyAnimCnt += 1
				if 0 <= EnemyAnimCnt and EnemyAnimCnt<60:
					GlobalNode.EnFrmState = GlobalNode.EnFrmStateID.OUTER
				elif 60 <= EnemyAnimCnt and EnemyAnimCnt < 120:
					GlobalNode.EnFrmState = GlobalNode.EnFrmStateID.HOME
				elif 120<=EnemyAnimCnt:
					EnemyAnimCnt = 0

		#--------------------------------------------------	
		#Stage clear State 01
		#Guntret Move to Home Position & Clear Music Play
		GlobalNode.SUBSTATE.STAGE_CLEAR:
			
			$Sound/StartMusic.stop()
			yield(get_tree().create_timer(0.5), "timeout")
			#Clear Music
			if FlgStageClear == false:
				$Sound/StageClear.play()
				FlgStageClear = true
			
			$Guntret.position = $Guntret.position.move_toward(Vector2(GuntretHomePosX, GuntretHomePosY), delta * 100)
			if $Guntret.position == Vector2(GuntretHomePosX, GuntretHomePosY):
				GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_CLEAR02
			
			#バックグランドの星の速度設定　	
			if 0.5 < StageClearBgStarSpd:
				StageClearBgStarSpd-=0.1
				$BgColor/BackGroundStars.SetStarSpeed(StageClearBgStarSpd,1)
		
		#--------------------------------------------------	
		#Guntret Worp
		GlobalNode.SUBSTATE.STAGE_CLEAR02:
			$Guntret.position.y -= StageClearGuntret_SpdY * delta
			StageClearGuntret_SpdY += 5
			
			if 0.5 < StageClearBgStarSpd:
				StageClearBgStarSpd-=0.1
				$BgColor/BackGroundStars.SetStarSpeed(StageClearBgStarSpd,1)
			
			#タイミング合わせも兼ねて画面外にすっとばす
			if $Guntret.position.y < -4096:
				$Guntret.position.y = GuntretHomePosY
				
#----------------------------------------------------------------
				print("next Stage")
				#debug ０，１面しかまだないのでここで弾いてます　
				#if 1 <= EnemySeqStageNum:
				#	return
#----------------------------------------------------------------
				
				#Next Stage Init same Paramater
				EnemySeqStageNum += 1
				EnemySequence = EnemySeqList[EnemySeqStageNum]
				
				#Sequencer Stop
				SeqEnable = false
				
				#Sqp Pointer Reset
				SeqPtr=0
				SeqTimerFps=0
				FormationEnemyTimer = 0 #EnemyMoveTimer
				StageClearBgStarSpd=DEFSTARSPEED
				
				#Graphic Reset
				$BgColor/BackGroundStars.SetStarSpeed(DEFSTARSPEED,1)
				$Guntret.position.x = GuntretHomePosX
				$Guntret.position.y = GlobalNode.ScreenHeight + 16 #GuntretHomePosY
				
				#Enemy Reset
				EnemyList.clear()
				LoopSeqEnd=false
				
				#Flg Init	
				SeqEnable = true
				FlgStageClear = false
				$CanvasStageClear.visible = false
				GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_START
					
				yield(get_tree().create_timer(0.5), "timeout")
				$Sound/StartMusic.play()

	#Game Over	----------------------------------------------------------------		
	if GlobalNode.GameState == GlobalNode.GState.GAMEOVER:
		#初回呼び出しの時だけハイスコア処理してる　
		if HighScoreCheck == false:
			$CanvasGameover/lblScore.text = "Score:%010d" % GlobalNode.PlayerScore
			HighScoreCheck = true
			if GlobalNode.HighScore < GlobalNode.PlayerScore:
				$CanvasGameover/lblHighScore.visible = true
				GlobalNode.HighScore = GlobalNode.PlayerScore
				GlobalNode.DataSave()
			else:
				$CanvasGameover/lblHighScore.visible = false
		
		#ゲームオーバー
		$CanvasGameover/lblHitAnyKey.visible = false
		$CanvasGameover.visible = true
		
		yield(get_tree().create_timer(5), "timeout")
		
		$CanvasGameover/lblHitAnyKey.visible = true
		
		var col = OS.get_ticks_usec()
		if col % 3 == 0:
			col = OS.get_ticks_usec() % GlobalNode.Colormax
			$CanvasGameover/lblHitAnyKey.add_color_override("font_color", ColorN(GlobalNode.ColorName[col]))
			
		#キー入力でタイトルへ　
		if Input.is_action_just_pressed("Shot"):	
			get_parent().GameTitleInit()
			queue_free()
		return
	
	#Pause r--------------------------------------------------------------
	if Input.is_action_pressed("Pause"):
		get_tree().paused = true
		$DlgPause.visible = true
		$DlgPause.show_modal(true)
	
#ポーズダイアログを閉じた時の処理
func _on_DlgPause_tree_exited() -> void:
	if get_owner() != null:
		get_tree().paused = false	

# 1/60 で呼ばれます
#各タイマカウントを更新し、シーケンス処理を呼び出します
func _on_SeqTimer_timeout() -> void:
	if GlobalNode.GameState != GlobalNode.GState.GAMEPLAY:
		return
	
	#print("Call Seq Timer")
	
	SeqTimerFps += 1#フレーム
	
	if 59 < SeqTimerFps:
		SeqTimerFps=0
		SeqTimerSec+=1
		SeqTimerGbl+=1
	SeqState()

#画面を振動させる
func DispShakeStart(var Count, var Width):
	DispShake = true
	DispShakeCount = Count
	DispShakeWidth = Width

#画面振動タイマ
func _on_DspShakeTimer_timeout() -> void:
	if DispShake == true:
		position.x = rand_range(-1, 1) * rand_range(0, DispShakeWidth) + 1	#振動させる	
		position.y = rand_range(-1, 1) * rand_range(0, DispShakeWidth) + 1
		DispShakeCount-=1
		
		if DispShakeCount <= 0:
			DispShake = false
	else:
		position.x = 0
		position.y = 0
