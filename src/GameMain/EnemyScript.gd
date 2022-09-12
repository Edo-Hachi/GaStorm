extends Node

#移動速度定数
const Spd_05 = 0.5
const Spd_06 = 0.6
const Spd_07 = 0.7
const Spd_08 = 0.8


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


var StateSeq01 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化

		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
		#音楽変更　
		{"Cmd" : "AudioStreamSet", "Music" : "StartMusic"},
		
		{"Cmd" : "MsgStageStart", "Num" : 1}, #ステージ開始テキスト描画
		{"Cmd" : "EnmyFormationActive", "Flg" : false}, #エネミーフォーメイションスタンバイ　 
		
		#Attack(編隊攻撃開始フラグ兼、攻撃率) #Shot(敵弾発射フラグ兼、攻撃率) #自機狙い弾を撃つか それぞれ-1ならfalse
		{"Cmd" : "EnemyStrength", "Attack" : -1, "Shot": 500, "Aim":false},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,1), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,1), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,4), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,4), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},


		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(2,0), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,0), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(5,0), "Spd":Spd_05},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,0), "Spd":Spd_05},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 
		{"Cmd" : "EnmyFormationAttack", "Flg" : true}, #エネミーフォーメイション攻撃開始 

		#Attack(編隊攻撃開始フラグ兼、攻撃率) #Shot(敵弾発射フラグ兼、攻撃率) #自機狙い弾を撃つか それぞれ-1ならfalse
		{"Cmd" : "EnemyStrength", "Attack" : 500, "Shot": 500, "Aim":false}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある

		{"Cmd" : "End"}
]

var StateSeq02 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化

		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
		#音楽変更　
		{"Cmd" : "AudioStreamSet", "Music" : "StartMusic"},
		
		{"Cmd" : "MsgStageStart", "Num" : 2}, #ステージ開始テキスト描画
		{"Cmd" : "EnmyFormationActive", "Flg" : false}, #エネミーフォーメイションスタンバイ　 
		
		#Attack(編隊攻撃開始フラグ兼、攻撃率) #Shot(敵弾発射フラグ兼、攻撃率) #自機狙い弾を撃つか それぞれ-1ならfalse
		{"Cmd" : "EnemyStrength", "Attack" : -1, "Shot": 400, "Aim":false},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,1), "Spd":Spd_06},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,1), "Spd":Spd_06},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,4), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(2,0), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,0), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Yellow, "Matrix":Vector2(5,0), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,0), "Spd":Spd_06},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 
		{"Cmd" : "EnmyFormationAttack", "Flg" : true}, #エネミーフォーメイション攻撃開始 

		#Attack(編隊攻撃開始フラグ兼、攻撃率) #Shot(敵弾発射フラグ兼、攻撃率) #自機狙い弾を撃つか それぞれ-1ならfalse
		{"Cmd" : "EnemyStrength", "Attack" : 4000, "Shot": 1000, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある

		{"Cmd" : "End"}
]

var StateSeq03 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化

		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
		#音楽変更　
		{"Cmd" : "AudioStreamSet", "Music" : "StartMusic"},
		
		{"Cmd" : "MsgStageStart", "Num" : 3}, #ステージ開始テキスト描画
		{"Cmd" : "EnmyFormationActive", "Flg" : false}, #エネミーフォーメイションスタンバイ　 
		
		#Attack(編隊攻撃開始フラグ兼、攻撃率) #Shot(敵弾発射フラグ兼、攻撃率) #自機狙い弾を撃つか それぞれ-1ならfalse
		{"Cmd" : "EnemyStrength", "Attack" : -1, "Shot": 400, "Aim":true},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(6,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,1), "Spd":Spd_06},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,1), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,1), "Spd":Spd_06},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(6,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left03, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(6,3), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.LeftPath04A, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4), "Spd":Spd_07},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.LeftPath04B, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.LeftPath04A, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,4), "Spd":Spd_07},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.LeftPath04B, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.LeftPath04A, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4), "Spd":Spd_07},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.LeftPath04B, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.LeftPath04A, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,4), "Spd":Spd_07},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.LeftPath04B, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,4), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RightPath04A, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,2), "Spd":Spd_07},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RightPath04B, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RightPath04A, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,3), "Spd":Spd_07},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RightPath04B, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RightPath04A, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,2), "Spd":Spd_07},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RightPath04B, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RightPath04A, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,3), "Spd":Spd_07},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RightPath04B, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,3), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Black, "Matrix":Vector2(2,0), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Black, "Matrix":Vector2(3,0), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Black, "Matrix":Vector2(5,0), "Spd":Spd_06},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Black, "Matrix":Vector2(4,0), "Spd":Spd_06},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 
		{"Cmd" : "EnmyFormationAttack", "Flg" : true}, #エネミーフォーメイション攻撃開始 

		#Attack(編隊攻撃開始フラグ兼、攻撃率) #Shot(敵弾発射フラグ兼、攻撃率) #自機狙い弾を撃つか それぞれ-1ならfalse
		{"Cmd" : "EnemyStrength", "Attack" : 4000, "Shot": 800, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある

		{"Cmd" : "End"}
]

#バックスクロール面
var StateSeq04 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化

#		{"Cmd" : "EnmyFormationActive", "Flg" : false}, #エネミーフォーメイションスタンバイ　 
		{"Cmd" : "MsgStageStart", "Num" : 4}, #ステージ開始テキスト描画
		#最初は通常スクロール
		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "EnemyStrength", "Attack" : -1, "Shot": -1, "Aim":false}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある
		
		#バックスクロール開始
		#export var StarSpeed = 5 #小さくすると速くなるよ / StarDirection = 1 #-1にすると逆スクロールだよ　
		{"Cmd" : "BgStarScroll", "Spd" : 3, "Dir": -1},
		#音楽変更　
		{"Cmd" : "AudioStreamSet", "Music" : "BackScroll"},
		

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft04, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft04, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft04, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft04, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft04, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight04, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight04, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight04, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight04, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight04, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
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

		{"Cmd" : "Wait_s", "Time" : 3},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgLeft02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},

		{"Cmd" : "Wait_s", "Time" : 3},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.RevStgRight02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":0.4},
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

var StateSeq05 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化

		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
		#音楽変更　
		{"Cmd" : "AudioStreamSet", "Music" : "StartMusic"},
		
		{"Cmd" : "MsgStageStart", "Num" : 5}, #ステージ開始テキスト描画
		{"Cmd" : "EnmyFormationActive", "Flg" : false}, #エネミーフォーメイションスタンバイ　 
		
		#Attack(編隊攻撃開始フラグ兼、攻撃率) #Shot(敵弾発射フラグ兼、攻撃率) #自機狙い弾を撃つか それぞれ-1ならfalse
		{"Cmd" : "EnemyStrength", "Attack" : 800, "Shot": 700, "Aim":true},

		{"Cmd" : "Wait_f", "Time" : 3},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(7,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3), "Spd":Spd_07},

		#{"Cmd" : "Wait_s", "Time" : 1},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,1), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(0,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3), "Spd":Spd_07},

		#{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,4), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,4), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3), "Spd":Spd_07},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3), "Spd":Spd_07},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3), "Spd":Spd_07},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 
		{"Cmd" : "EnmyFormationAttack", "Flg" : true}, #エネミーフォーメイション攻撃開始 

		#Attack(編隊攻撃開始フラグ兼、攻撃率) #Shot(敵弾発射フラグ兼、攻撃率) #自機狙い弾を撃つか それぞれ-1ならfalse
		{"Cmd" : "EnemyStrength", "Attack" : 800, "Shot": 600, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある

		{"Cmd" : "End"}
]

var StateSeq06 = [
		{"Cmd" : "Init_s"},	#1秒タイマ初期化
		{"Cmd" : "Init_f"},	#フレーム単位初期化
		{"Cmd" : "Init_g"},	#グローバルタイマ初期化

		{"Cmd" : "BgStarScroll", "Spd" : 5, "Dir": 1},
		#音楽変更　
		{"Cmd" : "AudioStreamSet", "Music" : "StartMusic"},
		
		{"Cmd" : "MsgStageStart", "Num" : 6}, #ステージ開始テキスト描画
		{"Cmd" : "EnmyFormationActive", "Flg" : false}, #エネミーフォーメイションスタンバイ　 
		
		#Attack(編隊攻撃開始フラグ兼、攻撃率) #Shot(敵弾発射フラグ兼、攻撃率) #自機狙い弾を撃つか それぞれ-1ならfalse
		{"Cmd" : "EnemyStrength", "Attack" : 800, "Shot": 800, "Aim":true},

		{"Cmd" : "Wait_f", "Time" : 3},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(7,2), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,2), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,3), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,3), "Spd":Spd_08},

		#{"Cmd" : "Wait_s", "Time" : 1},
		
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,1), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,1), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,1), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,1), "Spd":Spd_08},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(0,2), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,2), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,3), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,3), "Spd":Spd_08},

		#{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(7,4), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(6,4), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,4), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(4,4), "Spd":Spd_08},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(0,4), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(1,4), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,4), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right01, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(3,4), "Spd":Spd_08},

		{"Cmd" : "Wait_s", "Time" : 1},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(2,2), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,2), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(2,3), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Right02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(3,3), "Spd":Spd_08},

		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Red, "Matrix":Vector2(5,2), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,2), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(5,3), "Spd":Spd_08},
		{"Cmd" : "Wait_f", "Time" : 5},
		{"Cmd" : "LoopEnmy", "LoopType" : GlobalNode.LoopType.Left02, "Color": GlobalNode.EnemyColor.Green, "Matrix":Vector2(4,3), "Spd":Spd_08},

		{"Cmd" : "Wait_s", "Time" : 2},

		{"Cmd" : "EnmyFormationActive", "Flg" : true}, #エネミーフォーメイション実行 
		{"Cmd" : "EnmyFormationAnim", "Flg" : GlobalNode.EnFrmStateID.OUTER}, #エネミーフォーメイションアニメ開始 
		{"Cmd" : "EnmyFormationAttack", "Flg" : true}, #エネミーフォーメイション攻撃開始 

		#Attack(編隊攻撃開始フラグ兼、攻撃率) #Shot(敵弾発射フラグ兼、攻撃率) #自機狙い弾を撃つか それぞれ-1ならfalse
		{"Cmd" : "EnemyStrength", "Attack" : 800, "Shot": 800, "Aim":true}, #-1なら弾を撃たない Aim==trueだと狙って撃ってくる事がある

		{"Cmd" : "End"}
]

	
func _ready() -> void:
	pass # Replace with function body.
