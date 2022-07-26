#GameMain_Node2D

extends Node2D

var BulletScene = preload("res://src/GameMain/Guntret/Bullet_Area2D.tscn")

var EnemyLoopScene = preload("res://src/GameMain/Enemies/PathFollowEnemies.tscn")
var EnemyScene = preload("res://src/GameMain/Enemies/Enemy_Area2D.tscn")


var StateSeq = [
		{"Cmd" : "Init_s"},	#1秒
		{"Cmd" : "Init_f"},	#フレーム単位
		{"Cmd" : "Init_g"},	#グローバルタイマ
		
		#{"Cmd" : "Wait_s", "Time" : 3},
		{"Cmd" : "Wait_g", "Time" : 3},
		
		{"Cmd" : "Wait_f", "Time" : 3},
		{"Cmd" : "LoopEnmy", "Type" : 0},
		{"Cmd" : "Wait_f", "Time" : 3},
		{"Cmd" : "LoopEnmy", "Type" : 0},
		{"Cmd" : "Wait_f", "Time" : 3},
		{"Cmd" : "LoopEnmy", "Type" : 0},
		{"Cmd" : "Wait_f", "Time" : 3},
		{"Cmd" : "LoopEnmy", "Type" : 0},

		{"Cmd" : "End"}
	]
var SeqTimerGbl = 0 #グローバルタイマ
var SeqTimerSec = 0	#シーンシーケンスの制御タイマ(1秒)
var SeqTimerFps = 0#フレーム
var SeqPtr = 0	#シーケンス参照ポインタ
var SeqEnable = false

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var _GameOverTimer : float = 0.0


var debug_spawn = 0

enum ENEMY_STAT {LOOP, MOVE, PORC, ATAK, DEAD}


var EnemyManageList = []
class ENEMY_MANAGE:
	var EnemyId
	var LoopId
	
	var LoopObj : Object
	var EnemyObl : Object
	
	var StartPosition : Vector2
	var LastPosition : Vector2
	var State : int
	

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
			print("LoopEnemyType:", Seq["Type"])
			LoopEnemySpawn(0)

			SeqPtr+=1
			
		"End":
			SeqEnable=false
			#print("End")
	
	#SeqPtr+=1


#--------------------------------------------
func LoopEnemySpawn(var LoopType):
	var EnemyManage = ENEMY_MANAGE.new()
	
	var ListMax = EnemyManageList.size()
	
	#オブジェクト生成	
	var ScnLoop = EnemyLoopScene.instance()	#ループ
	var ScnEnemy = EnemyScene.instance()	#エネミー
	
	
	var loopid = ScnLoop.get_instance_id()
	ScnLoop.SetLoopType(LoopType)
	ScnLoop.SetEnemyId(ScnEnemy)
	ScnLoop.SetLoopId(loopid)
	add_child(ScnLoop)
	
	#エネミー生成
	var enid = ScnEnemy.get_instance_id()
	ScnEnemy.SetEnemyId(enid)
	add_child(ScnEnemy)
	
	
	EnemyManage.EnemyId = enid
	EnemyManage.LoopId = loopid
	EnemyManage.LoopObj = ScnLoop
	EnemyManage.EnemyObl = ScnEnemy
	EnemyManage.State = ENEMY_STAT.LOOP

func UpdateEnemyPos(var EnemyObj, var pos:Vector2):
	EnemyObj.position = pos
	
func LoopEnemyOver(var EnemyId, var pos : Vector2):
	print("LoopOver")
	
	pass

func LoopEnemyDead():
	pass


#	var EnemyId : int
#	var StartPosition : Vector2
#	var LastPosition : Vector2
#	var State : int
#
#	var LoopObj
#	var EnemyObl	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("Call Ready")
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
	
	
	#--------------------------------------------------------------
	if Input.is_action_pressed("SpawnEnemy"):
		if debug_spawn == 0:
			SeqEnable = true
			print("Seq Start")
			#LoopEnemySpawn(0)
			debug_spawn = 1
	
	if GlobalNode.GameState == GlobalNode.GState.GAMEOVER:
		_GameOverTimer+=1
		$CanvasLayer/lblGameOver.visible = true
		if (60 * 5) < _GameOverTimer:
			get_tree().change_scene("res://src/Main_Node2D.tscn")
		

#ポーズダイアログを閉じた時の処理
func _on_DlgPause_tree_exited() -> void:
	if get_owner() != null:
		get_tree().paused = false	
 

# 1/60 で呼ばれます
func _on_SeqTimer_timeout() -> void:
	SeqTimerFps += 1#フレーム
	
	if 59 < SeqTimerFps:
		SeqTimerFps=0
		SeqTimerSec+=1
		SeqTimerGbl+=1

	SeqState()

