extends Node

var StateSeq01 = [
		{"Cmd" : "Init_s"},	#1秒
		{"Cmd" : "Init_f"},	#フレーム単位
		{"Cmd" : "Init_g"},	#グローバルタイマ
		
		#{"Cmd" : "FormationFlg", "Flg" : 0},	#フォーメーションアニメ停止

		#{"Cmd" : "Wait_s", "Time" : 3},
		{"Cmd" : "Wait_g", "Time" : 1},
		
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,1)},

		{"Cmd" : "Wait_s", "Time" : 5},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,1)},
#
#		{"Cmd" : "Wait_s", "Time" : 4},
#
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(7,2)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3)},
#
#		{"Cmd" : "Wait_s", "Time" : 3},
#
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(0,2)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3)},
#
#		{"Cmd" : "Wait_s", "Time" : 3},
#
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,4)},
#
#		{"Cmd" : "Wait_s", "Time" : 1},
#
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,4)},
#
#		{"Cmd" : "Wait_s", "Time" : 3},
#
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,2)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3)},
#
#		{"Cmd" : "Wait_s", "Time" : 1},
#
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,2)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3)},
#		{"Cmd" : "Wait_f", "Time" : 5},
#		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3)},
		
		{"Cmd" : "Wait_s", "Time" : 2},
		{"Cmd" : "FormationFlg", "Flg" : 1},	#フォーメーションアニメ開始

		{"Cmd" : "End"}
	]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
