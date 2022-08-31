extends Node

var StateBoss = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化

		{"Cmd" : "EnemyStrength", "Attack" : 4000, "Shot": 4000, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある


		{"Cmd" : "MsgStageStart", "Num" : 10}, #ステージ開始テキスト描画
		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},

		#export var StarSpeed = 5 #小さくすると速くなるよ / StarDirection = 1 #-1にすると逆スクロールだよ　
		{"Cmd" : "BgStarScroll", "Spd" : 3, "Dir": -1},

		#音楽変更　
		{"Cmd" : "AudioStreamSet", "Music" : "BackScroll"},
		
		{"Cmd" : "SpwnLastBoss"},
		{"Cmd" : "End"},		
]

const Spd_05 = 0.5
var StateSeq01 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化

		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
		#音楽変更　
		{"Cmd" : "AudioStreamSet", "Music" : "StartMusic"},
		
		{"Cmd" : "MsgStageStart", "Num" : 1}, #ステージ開始テキスト描画
		{"Cmd" : "EnmyFormationActive", "Flg" : false}, #エネミーフォーメイションスタンバイ　 
		#{"Cmd" : "EnemyStrength", "Attack" : 500, "Shot": 500, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある
		{"Cmd" : "EnemyStrength", "Attack" : -1, "Shot": 500, "Aim":false}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,1), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(7,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,1), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(0,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,4), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,4), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 
		{"Cmd" : "EnmyFormationAttack", "Flg" : true}, #エネミーフォーメイション攻撃開始 

		{"Cmd" : "EnemyStrength", "Attack" : 500, "Shot": 500, "Aim":false}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある

		{"Cmd" : "End"}
]

var StateSeq02 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化
		
		{"Cmd" : "EnemyStrength", "Attack" : 2000, "Shot": 2000, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある

		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 
		
#		{"Cmd" : "EnmyFormationActive", "Flg" : false}, #エネミーフォーメイションスタンバイ　 
#		{"Cmd" : "MsgStageStart", "Num" : 2}, #ステージ開始テキスト描画
		
		{"Cmd" : "Wait_s", "Time" : 2},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,1), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 5},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,1), "Spd":0.5},
		

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(7,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(0,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,4), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,4), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3), "Spd":0.5},

		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 
		{"Cmd" : "EnmyFormationAttack", "Flg" : true}, #エネミーフォーメイション攻撃開始 
		
		{"Cmd" : "End"}
	]

var StateSeq03 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化
		
		{"Cmd" : "EnemyStrength", "Attack" : 4000, "Shot": 4000, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある

		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
#		{"Cmd" : "EnmyFormationActive", "Flg" : false}, #エネミーフォーメイションスタンバイ　 
		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 

		
		{"Cmd" : "MsgStageStart", "Num" : 3}, #ステージ開始テキスト描画
		
		{"Cmd" : "Wait_s", "Time" : 2},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(0,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,1), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 5},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,1), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,1), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(7,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(0,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,4), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,4), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3), "Spd":0.5},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3), "Spd":0.5},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3), "Spd":0.5},
		
		{"Cmd" : "Wait_s", "Time" : 4},
		{"Cmd" : "End"}
	]

var StateSeq04 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化

#		{"Cmd" : "EnmyFormationActive", "Flg" : false}, #エネミーフォーメイションスタンバイ　 
		{"Cmd" : "MsgStageStart", "Num" : 4}, #ステージ開始テキスト描画
		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},

		{"Cmd" : "Wait_s", "Time" : 2},


		{"Cmd" : "EnemyStrength", "Attack" : -1, "Shot": -1, "Aim":false}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある
		
#		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
#		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 

		{"Cmd" : "Wait_s", "Time" : 2},

		#export var StarSpeed = 5 #小さくすると速くなるよ / StarDirection = 1 #-1にすると逆スクロールだよ　
		{"Cmd" : "BgStarScroll", "Spd" : 3, "Dir": -1},
		#音楽変更　
		{"Cmd" : "AudioStreamSet", "Music" : "BackScroll"},
		
		{"Cmd" : "Wait_s", "Time" : 2},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		
		{"Cmd" : "Wait_s", "Time" : 4},
		{"Cmd" : "End"}
	]

#インベーダー面
var StateSeq05 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化

		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
		
		{"Cmd" : "MsgStageStart", "Num" : 5}, #ステージ開始テキスト描画

		{"Cmd" : "EnemyStrength", "Attack" : 500, "Shot": 500, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(7,1), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(6,1), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(5,1), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(4,1), "Spd":0.8},

		{"Cmd" : "Wait_f", "Time" : 20}
		,
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(7,2), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(6,2), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(7,3), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(6,3), "Spd":0.8},

		#{"Cmd" : "Wait_s", "Time" : 3},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(0,1), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(1,1), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(2,1), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(3,1), "Spd":0.8},

		#{"Cmd" : "Wait_s", "Time" : 5},


		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(0,2), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(1,2), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(0,3), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(1,3), "Spd":0.8},

		#{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(7,4), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(6,4), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(5,4), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(4,4), "Spd":0.8},

		#{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(0,4), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(1,4), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(2,4), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(3,4), "Spd":0.8},

		#{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(2,2), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(3,2), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(2,3), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(3,3), "Spd":0.8},

		#{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(5,2), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(4,2), "Spd":0.8},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(5,3), "Spd":0.8},
		
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(4,3), "Spd":0.8},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 
		{"Cmd" : "EnmyFormationAttack", "Flg" : true}, #エネミーフォーメイション攻撃開始 

		{"Cmd" : "End"}
	]

	
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
