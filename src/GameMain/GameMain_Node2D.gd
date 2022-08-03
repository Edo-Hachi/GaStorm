#GameMain_Node2D

extends Node2D

var BulletScene = preload("res://src/GameMain/Guntret/Bullet_Area2D.tscn")

#var EnemyLoopScene = preload("res://src/GameMain/Enemies/PathFollowEnemies.tscn")
var EnemyLoopScene = preload("res://src/GameMain/Enemies/PathFollowEnemies02.tscn")
var EnemyScene = preload("res://src/GameMain/Enemies/Enemy_Area2D.tscn")


class ENEMY_MATRIX:
	var Col : int
	var Row : int
	var WorldX : float
	var WorldY : float
	var State : int
	
	
	
	

#----------------------------------------------------------------------------
var MatrixCol = 8
var MatrixRow = 5
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


var StateSeq = [
		{"Cmd" : "Init_s"},	#1秒
		{"Cmd" : "Init_f"},	#フレーム単位
		{"Cmd" : "Init_g"},	#グローバルタイマ
		
		#{"Cmd" : "Wait_s", "Time" : 3},
		{"Cmd" : "Wait_g", "Time" : 1},
		
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType":GlobalNode.LoopType.Left01, "Color":GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1) },
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,1)},

		{"Cmd" : "Wait_s", "Time" : 1},
		{"Cmd" : "Wait_g", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(7,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(6,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,1)},
		
		{"Cmd" : "End"}
	]
	
var SeqTimerGbl = 0 #グローバルタイマ
var SeqTimerSec = 0	#シーンシーケンスの制御タイマ(1秒)
var SeqTimerFps = 0#フレーム
var SeqPtr = 0	#シーケンス参照ポインタ
var SeqEnable = false


var _GameOverTimer : float = 0.0

var debug_spawn = 0

enum ENEMY_STAT {LOOP, MOVE, PORC, ATAK, DEAD}


	

func SeqState():
	if SeqEnable==false:
		return
	
	var Seq
	
	if SeqPtr < StateSeq.size():
		Seq = StateSeq[SeqPtr]
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
				print("Sec Process ", Seq["Time"], "sec")
				SeqTimerSec=0
				SeqPtr+=1
		
		"Wait_f":
			if SeqTimerFps == Seq["Time"]:
				print("Fps Process ", Seq["Time"], "Fps")
				SeqTimerFps=0
				SeqPtr+=1
			
		"Wait_g":
			if SeqTimerGbl == Seq["Time"]:
				print("GrobalTime Process ", Seq["Time"], "Time")
				SeqPtr+=1
		"LoopEnmy":
			LoopEnemySpawn(Seq["LoopType"], Seq["Color"], Seq["Matrix"])
			SeqPtr+=1
			
		"End":
			SeqEnable=false
			#print("End")
	
	#SeqPtr+=1


#--------------------------------------------
func LoopEnemySpawn(var LoopType : int, var EnemyColor : int, var Matrix:Vector2) -> void:

	#オブジェクト生成	
	var ScnLoop = EnemyLoopScene.instance()	#ループ
	var ScnEnemy = EnemyScene.instance()	#エネミー

	#エネミー生成------------------------------------------
	var enid = ScnEnemy.get_instance_id()
	ScnEnemy.SetEnemyId(enid)
	ScnEnemy.SetEnemyColor(EnemyColor)
	
	#ここもっとスマートにかけない？ debug
	var tmp :ENEMY_MATRIX =	EnemyMatrix[Pos2Index(Matrix.x, Matrix.y)]
	ScnEnemy.SetEnemyMatrix(Matrix, Vector2(tmp.WorldX, tmp.WorldY))
	
	add_child(ScnEnemy)
	#エネミー生成------------------------------------------
	
	#ループ生成-------------------------------------------
	var loopid = ScnLoop.get_instance_id()
	ScnLoop.InitLoopEnemies(ScnEnemy,loopid, LoopType)
	add_child(ScnLoop)
	#ループ生成-------------------------------------------
	
func LoopEnemyOver(var EnemyId, var NowPos : Vector2, var ToPos : Vector2):
		
	
	#ループ処理が終わると終了したエネミーのオブジェクトIDが戻って売る
	if EnemyId.Alive == false:	#ループ処理から戻ってきたタイミングで破壊されていたらならエネミーのオブジェクトをガベコレ
		EnemyId.queue_free()
	else:	
		print("LoopOver and Next Move State")
		
		#グリッド所定位置へ移動　
		#var MoveToPos : Vector2()
		#EnemyId.position = position.move_toward(ToPos, 0.05)
		#EnemyId.position = ToPos
		
		#DebugMoveEnemyList.append(EnemyId)
		#print(DebugMoveEnemyList.size())
		pass
		
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("Call Ready")
	
	InitEnemyMatrix()
		
	$Guntret.position.x = GlobalNode.ScreenWidth / 2
	$Guntret.position.y = GlobalNode.ScreenHeight -32
	GlobalNode.PlayerScore = 0
	GlobalNode.GameMainSceneID = get_owner()

func set_erase_enemy(var id):
	pass
	#print("set_erase_enemy hoge ",id)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#debug
#	var myid = get_tree()
#	GlobalNode.GameMainSceneID = get_tree()
#	GlobalNode.GameMainSceneID
	
	if Input.is_action_pressed("Pause"):
		get_tree().paused = true
		$DlgPause.visible = true
		$DlgPause.show_modal(true)
	
	if Input.is_action_pressed("GameOver"):
		GlobalNode.GameState = GlobalNode.GState.GAMEOVER
		_GameOverTimer = 0
	
	
#debug--------------------------------------------------------------
	if Input.is_action_pressed("SpawnEnemy"):
		if debug_spawn == 0:
			debug_spawn = 1
			#エネミー生成------------------------------------------
#			var ScnEnemy = EnemyScene.instance()	#エネミー
#			var enid = ScnEnemy.get_instance_id()
#			ScnEnemy.SetEnemyId(enid)
#			ScnEnemy.position = Vector2(128, 128)
#			add_child(ScnEnemy)
			#エネミー生成------------------------------------------

			
#-------------------------------
			SeqEnable = true
			#print("Seq Start")
			#LoopEnemySpawn(0)
			debug_spawn = 1
#-------------------------------
#debug--------------------------------------------------------------
	
	if GlobalNode.GameState == GlobalNode.GState.GAMEOVER:
		_GameOverTimer+=1
		$CanvasLayer/lblGameOver.visible = true
		if (60 * 5) < _GameOverTimer:
			get_tree().change_scene("res://src/Main_Node2D.tscn")
		

	#ループが終わったエネミーを隊列位置に移動するテストコード
#	for i in DebugMoveEnemyList.size():
#		#print("Update Move Enemy Count:",DebugMoveEnemyList[i])
#		DebugMoveEnemyList[i].position = DebugMoveEnemyList[i].position.move_toward(Vector2(128,250), 50 * delta)


#ポーズダイアログを閉じた時の処理
func _on_DlgPause_tree_exited() -> void:
	if get_owner() != null:
		get_tree().paused = false	
 

# 1/60 で呼ばれます
#各タイマカウントを更新し、シーケンス処理を呼び出します
func _on_SeqTimer_timeout() -> void:
	SeqTimerFps += 1#フレーム
	
	if 59 < SeqTimerFps:
		SeqTimerFps=0
		SeqTimerSec+=1
		SeqTimerGbl+=1

	SeqState()

