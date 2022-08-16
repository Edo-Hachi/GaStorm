extends Node

var StateSeq01 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化

		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
		
		{"Cmd" : "MsgStageStart", "Num" : 1}, #ステージ開始テキスト描画
		{"Cmd" : "EnmyFormationActive", "Flg" : false}, #エネミーフォーメイションスタンバイ　 

		{"Cmd" : "Wait_s", "Time" : 3},

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

		{"Cmd" : "Wait_s", "Time" : 4},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(7,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(0,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,4)},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,4)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3)},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3)},
#
		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
		{"Cmd" : "Wait_s", "Time" : 4},

		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 

		{"Cmd" : "End"}
]

var StateSeq02 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化
		
		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
		
		{"Cmd" : "MsgStageStart", "Num" : 2}, #ステージ開始テキスト描画
		
		{"Cmd" : "Wait_s", "Time" : 2},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,1)},

		{"Cmd" : "Wait_s", "Time" : 5},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,1)},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(7,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(0,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,4)},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,4)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3)},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3)},
		
		{"Cmd" : "Wait_s", "Time" : 4},
		{"Cmd" : "End"}
	]

var StateSeq03 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化
		
		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
		
		{"Cmd" : "MsgStageStart", "Num" : 3}, #ステージ開始テキスト描画
		
		{"Cmd" : "Wait_s", "Time" : 2},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Purple, "Matrix":Vector2(0,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,1)},

		{"Cmd" : "Wait_s", "Time" : 5},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,1)},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(7,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(0,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,4)},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,4)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3)},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3)},
		
		{"Cmd" : "Wait_s", "Time" : 4},
		{"Cmd" : "End"}
	]

var StateSeq04 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化
		
		{"Cmd" : "MsgStageStart", "Num" : 4}, #ステージ開始テキスト描画
		
		{"Cmd" : "Wait_s", "Time" : 2},
		
		#export var StarSpeed = 5 #小さくすると速くなるよ
		#export var StarDirection = 1 #-1にすると逆スクロールだよ　
		{"Cmd" : "BgStarScroll", "Spd" : 3, "Dir": -1},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Purple, "Matrix":Vector2(0,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,1)},

		{"Cmd" : "Wait_s", "Time" : 5},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,1)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,1)},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(7,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(0,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,4)},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,4)},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3)},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3)},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3)},
		
		{"Cmd" : "Wait_s", "Time" : 4},
		{"Cmd" : "End"}
	]
	
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
