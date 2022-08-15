extends Node2D

var BulletScene = preload("res://src/GameMain/Guntret/Bullet_Area2D.tscn")
var EnemyLoopScene = preload("res://src/GameMain/Enemies/PathFollowEnemies.tscn")
var EnemyScene = preload("res://src/GameMain/Enemies/Enemy_Area2D.tscn")
var EnemyBulletScn = preload("res://src/GameMain/Enemies/EnemyBullet.tscn")


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
	
	var ypos=0
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
#var  MatrixCol = 8
#var  MatrixRow = 5
func Pos2Index(var x , var y):
	return x + (MatrixCol * y)

#----------------------------------------------------------------------------
#エネミーを隊列で並べる時のグリッド座標情報

#画面上のエネミー管理リスト
var EnemyList = []
var LoopSeqEnd = false
	
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
#----------------------------------------------------------------------------

var _GameOverTimer : float = 0.0

var FormationEnemyTimer = 0	#エネミーの隊列アニメ


#自機のホームポジション
const GuntretHomePosX = GlobalNode.ScreenWidth / 2
const GuntretHomePosY = GlobalNode.ScreenHeight -32

#ステージクリアアニメーションのY速度
const DEFSTARSPEED = 5
var StageClearGuntret_SpdY = 10
var StageClearBgStarSpd = DEFSTARSPEED #default =5

#debug
var debug_spawn = 0

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
		"LoopEnmy":
			LoopEnemySpawn(Seq["LoopType"], Seq["Color"], Seq["Matrix"])
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
			SeqPtr+=1
		#{"Cmd" : "MsgStageStart", "Num" : 1},
		
		"BgStarScroll":
			#export var StarSpeed = 5 #小さくすると速くなるよ
			#export var StarDirection = 1 #-1にすると逆スクロールだよ　
			$BgColor/BackGroundStars.SetStarSpeed(Seq["Spd"], Seq["Dir"])
			SeqPtr+=1

			
			
			
		"End":
			#print("Sqe End")
			SeqEnable=false
			LoopSeqEnd = true
			
			#敵が0だったらステージクリアに
			if EnemyList.size() == 0:
				StageClearGuntret_SpdY = 10
				GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_CLEAR
				$CanvasStageClear.visible = true
	


#--------------------------------------------
func LoopEnemySpawn(var LoopType : int, var EnemyColor : int, var Matrix:Vector2) -> void:

	#オブジェクト生成	
	var ScnLoop = EnemyLoopScene.instance()	#ループ
	var ScnEnemy = EnemyScene.instance()	#エネミー

	#エネミー生成------------------------------------------
	var enid = ScnEnemy.get_instance_id()
	ScnEnemy.SetEnemyId(enid)
	ScnEnemy.SetEnemyColor(EnemyColor)

#debug	 ここをまるっと置き換える ーーーーーーーーーーーーーーーーーーーーーーーーー
	#var EnemyFormation # hold 1=move_outside 2=move_inner
	#enum EnemyFormationState {MOVE_STOP = 0, MOVE_LOOP, MOVE_HOME, MOVE_OUTSIDE, ATTACK}
	ScnEnemy.SetEnemyState(GlobalNode.EnemyStateID.STAT_LOOP)
#debug	 ここをまるっと置き換える ーーーーーーーーーーーーーーーーーーーーーーーーー
	
	#ここもっとスマートにかけない？
	var tmp :ENEMY_MATRIX =	EnemyMatrix[Pos2Index(Matrix.x, Matrix.y)]
	ScnEnemy.SetEnemyMatrix(Matrix, Vector2(tmp.WorldX, tmp.WorldY))
	add_child(ScnEnemy)
	
	#エネミー管理リストに追加(ステージ上の残エネミー数の管理にしか今のところ使ってない。無駄っぽい)
	
	AppendEnemy(ScnEnemy)
	#エネミー生成------------------------------------------
	
	#ループ生成-------------------------------------------
	var loopid = ScnLoop.get_instance_id()
	ScnLoop.InitLoopEnemies(ScnEnemy,loopid, LoopType)
	add_child(ScnLoop)
	#ループ生成-------------------------------------------

#FollowPath2D Seq Over!!	
func LoopEnemyOver(var EnemyId, var NowPos : Vector2, var ToPos : Vector2):
	
	#ループ処理が終わると終了したエネミーのオブジェクトIDが戻って売る
	if EnemyId.Alive == false:	#ループ処理から戻ってきたタイミングで破壊されていたらならエネミーのオブジェクトをガベコレ
		EnemyId.queue_free()
		
		#エネミーの生成リストから削除
		#DeleteEnemy()
	else:
		#ループの終わったエネミーはホームポジションへ
#debug	 ここをまるっと置き換える ーーーーーーーーーーーーーーーーーーーーーーーーー
	#var EnemyFormation # hold 1=move_outside 2=move_inner
	#enum EnemyFormationState {MOVE_STOP = 0, MOVE_LOOP, MOVE_HOME, MOVE_OUTSIDE, ATTACK}
		EnemyId.SetEnemyState(GlobalNode.EnemyStateID.STAT_GOHOME)
#debug	 ここをまるっと置き換える ーーーーーーーーーーーーーーーーーーーーーーーーー
		
		#画面上のエネミーをアクティブリストに追加(ホームポジションに落ち着いたエネミーをリストに追加しないと数あわないかも　)
#		EnemyList.append(EnemyId)
#		print("Active Enemy :",EnemyList.size() )

#エネミー管理リストへ追加
func AppendEnemy(var EnemyId):
		EnemyList.append(EnemyId)
		#print("Active Enemy :",EnemyList.size() )
	
#エネミー削除（エネミークラスからも呼ばれる）
func DeleteEnemy():
	EnemyList.pop_front()
	#print("Enemy Delete:",EnemyList.size(), " SeqFlg=" ,LoopSeqEnd)
	if EnemyList.size() == 0 and LoopSeqEnd==true: #hoge
		#StageClear
		#print("Stage Clear!!")
		StageClearGuntret_SpdY = 10
		GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_CLEAR
		$CanvasStageClear.visible = true
	
	#bug SeqEndのタイミングで残エネミーが０の場合もステージクリアにする必要あり

func ShotEnemyBullet(var EnemyPos : Vector2):
	var ScnBullet = EnemyBulletScn.instance()
	add_child(ScnBullet)
	ScnBullet.SetPos(EnemyPos)
#	ScnBullet.SetDegrees(45)
	#ScnBullet.SetToword(Vector2(200,100))
	ScnBullet.SetToword($Guntret.position)
		

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


	LoopSeqEnd=false

	StageClearBgStarSpd=DEFSTARSPEED
	$BgColor/BackGroundStars.SetStarSpeed(StageClearBgStarSpd,1)
	
	$Guntret.visible = true
	$RestGuntret.visible = true
	
	EnemyList.clear()
	
	GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_START
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("Call Ready")
	
	InitEnemyMatrix()
	FormationEnemyTimer = 0

	#自機のホームポジション
	$Guntret.position.x = GuntretHomePosX
	$Guntret.position.y = GuntretHomePosY
	GlobalNode.PlayerScore = 0
	GlobalNode.GameMainSceneID = get_owner()
	
	#hoge
	StageClearBgStarSpd=DEFSTARSPEED
	$BgColor/BackGroundStars.SetStarSpeed(StageClearBgStarSpd,1)

	#シーケンスリスト作成（なんかスマートに書けないかな？）
	#EnemySeqList.append($EnemyScript.StateSeq01)
	#EnemySeqList.append($EnemyScript.StateSeq02)
	#EnemySeqList.append($EnemyScript.StateSeq03)
	EnemySeqList.append($EnemyScript.StateSeq04)
	
	#EnemySequence = $EnemyScript.StateSeq01	#実行するシーケンスの辞書リスト
	
	SeqPtr=0
	SeqTimerFps=0
	SeqEnable = true
	
	#これでBGの星の操作できます　
	#get_parent().get_node("BackGroundStars").SetStarSpeed(1,-1)
	#$BgColor/BackGroundStars.SetStarSpeed(1,-1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalNode.GameState != GlobalNode.GState.GAMEPLAY:
		
		#エネミーのリストを調べて、全エネミーのEnemyStateが
		#GlobalNode.EnemyStateID.STAT_FORMATION
		#になっていたら、編隊でのアニメーション処理を行う
		
		#GlobalNodeに実行フラグを設けて、オフセット移動、ホームポジションへの戻りを
		#制御する
		
		return
	
	match GlobalNode.SubState:
		GlobalNode.SUBSTATE.STAGE_START:
			StageClearBgStarSpd=DEFSTARSPEED
			$BgColor/BackGroundStars.SetStarSpeed(StageClearBgStarSpd,1)
			#print("StageStart")
			$Guntret.position = $Guntret.position.move_toward(Vector2(GuntretHomePosX, GuntretHomePosY), delta * 100)
			GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_PLAY
			
			#debug 最終的には、Window.Height+32あたりからホームポジションにフレームインするアニメーションを実装したい　
		
		GlobalNode.SUBSTATE.STAGE_PLAY:
				pass
		GlobalNode.SUBSTATE.STAGE_CLEAR:
			$Guntret.position = $Guntret.position.move_toward(Vector2(GuntretHomePosX, GuntretHomePosY), delta * 100)
			if $Guntret.position == Vector2(GuntretHomePosX, GuntretHomePosY):
				GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_CLEAR02
				
			if 0.5 < StageClearBgStarSpd:
				StageClearBgStarSpd-=0.1
				$BgColor/BackGroundStars.SetStarSpeed(StageClearBgStarSpd,1)
		
		GlobalNode.SUBSTATE.STAGE_CLEAR02:
			$Guntret.position.y -= StageClearGuntret_SpdY * delta
			StageClearGuntret_SpdY += 10
			
			if 0.5 < StageClearBgStarSpd:
				StageClearBgStarSpd-=0.1
				$BgColor/BackGroundStars.SetStarSpeed(StageClearBgStarSpd,1)
			
			#if $Guntret.position.y < -64:
			if $Guntret.position.y < -2048:

				$Guntret.position.y = GuntretHomePosY
				
#----------------------------------------------------------------
				print("next Stage")
				#debug ０，１面しかまだないのでここで弾いてます　
				if 1 <= EnemySeqStageNum:
					return
#----------------------------------------------------------------
				
				EnemySeqStageNum += 1
				EnemySequence = EnemySeqList[EnemySeqStageNum]
				SeqEnable = false #debug
				
				SeqPtr=0
				SeqTimerFps=0
				FormationEnemyTimer = 0 #EnemyMoveTimer
				StageClearBgStarSpd=DEFSTARSPEED
				$BgColor/BackGroundStars.SetStarSpeed(StageClearBgStarSpd,1)
				
				$Guntret.position.x = GuntretHomePosX
				$Guntret.position.y = GlobalNode.ScreenHeight + 16 #GuntretHomePosY
				
				EnemyList.clear()
				LoopSeqEnd=false
				SeqEnable = true
				
				$CanvasStageClear.visible = false
				
				GlobalNode.SubState = GlobalNode.SUBSTATE.STAGE_START
				#----------------------------------------------------------------
	
	#Pause r--------------------------------------------------------------
	if Input.is_action_pressed("Pause"):
		get_tree().paused = true
		$DlgPause.visible = true
		$DlgPause.show_modal(true)
	
	
#debug--------------------------------------------------------------
	if Input.is_action_pressed("SpawnEnemy"):
		print("Enemy")
#		if debug_spawn == 0:
#			debug_spawn = 1
			
		var ScnBullet = EnemyBulletScn.instance()
		add_child(ScnBullet)
		ScnBullet.SetPos(Vector2(100,10))
#		ScnBullet.SetDegrees(45)
		#ScnBullet.SetToword(Vector2(200,100))
		ScnBullet.SetToword($Guntret.position)

			
#			LoopSeqEnd = false #debug ループスポーン開始フラグ
			
			#エネミー生成------------------------------------------
#			var ScnEnemy = EnemyScene.instance()	#エネミー
#			var enid = ScnEnemy.get_instance_id()
#			ScnEnemy.SetEnemyId(enid)
#			ScnEnemy.position = Vector2(128, 128)
#			add_child(ScnEnemy)
			#エネミー生成------------------------------------------

#debug--------------------------------------------------------------
	if Input.is_action_pressed("GameOver"):
		GlobalNode.GameState = GlobalNode.GState.GAMEOVER
		$CanvasGameover/Node2D.visible = true
		
		var timer = get_tree().create_timer(3) #falseにしないとポーズした時に止まってくれない
		yield(timer , "timeout")
		GlobalNode.GameState == GlobalNode.GState.TITLE
		get_parent().GameTitleInit()
#debug--------------------------------------------------------------



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

