extends Node

const Version = "Ver 0.01A"

#画面サイズ
const ScreenWidth = 256
const ScreenHeight = 256

var GameTime = 0

#ゲームステート	
enum GState {TITLE = 0, GAMEPLAY, GAMEOVER, GAME_CLEAR}
var GameState : int  = GState.TITLE

#インベーダーモード変数　
#var InvaderMode = false	#Enemy_Area2Dで参照するインベーダー動作モードフラグ
#var InvaderMove = 0		#インベーダーの進行方向管理用　0=左　1=右
#var InvaderCanMove = false	#インベーダー移動可能フラグ
#var InvaderOffsetX = 0	#インベーダー下方移動時のオフセット座標
#var InvaderOffsetY = 0	#インベーダー下方移動時のオフセット座標

#ゲームサブステート(GState.SUBSTATE)
enum SUBSTATE {STAGE_START=0, STAGE_PLAY, STAGE_CLEAR, STAGE_CLEAR02,GAMEOVER}
var SubState : int = SUBSTATE.STAGE_START

#ゲームシーケンス動作状況
var GameSeqActive  = false

var PlayerScore : int = 0
var HighScore : int = 10

var GameMainSceneID = 0

enum LoopType {Left01=0, Right01, Left02, Right02, RevStgLeft01, RevStgRight01}
enum EnemyColor {Green=0, Red, Yellow, Black} 

#エネミーの行動ステート
enum EnemyStateID {
		STAT_LOOP=0,	#現れた時のループ
		STAT_GOHOME,	#ホームポジションへの移動
		STAT_FORMATION,
		STAT_ATTACK		#攻撃中
}

#隊列を組んでいる時のエネミーの動作ステート
var EnemyFormationFinished = false	#Loop完了後に全エネミーがホームポジションに戻るとtrueになる　

#隊列からの攻撃許可フラグ
var EnemyFormationAttack = false

#エネミーのホームポジションアニメフラグ
enum EnFrmStateID{
	STOP = 0,
	HOME,
	OUTER
}
var EnFrmState = EnFrmStateID.STOP

#エネミーの攻撃パラメータ
var EnemyAttackRate : int	#エネミーが攻撃耐性に入る確率 -1なら編隊状態から攻撃モードに移行しない
var EnemyShotRate : int	#エネミーが弾を撃ってくる確率
var EnemyShotAim : bool	#自機狙い弾を撃ってくるかどうか true/false

#シーケンス実行中状態 実行中 = true / 終了 = false
var SeqState

#------------------
#var EnemyInvader = false
#var InvaderDir = 0
#var InvaderLeftX
#var InvaderRightX
#var InvaderTimer = 0
#var EnemyOffsetY=0
#------------------

#Color Name Like a Pico8 Colors)
var ColorName = ["black", "navyblue", "maroon", "darkgreen", "brown", "darkolivegreen", "darkgray", "cornsilk", "red", "darkorange", "yellow", "green",
					 "deepskyblue",  "dimgray", "hotpink",  "lightsalmon"]
var Colormax = ColorName.size()

#スクロールリバース面フラグ trueになってたらリバース面処理中
var BgScrollReverse = false
#var DspShake = false

var UserData = {
	"HighScore"  : 0
}

#Guntret realtime Position
var GuntretPos : Vector2

#ボスがつけているアクティブなビットの数
var BossBitNum

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func InitData(var fuga):
	PlayerScore = fuga
	
#C:\Users\-username-\AppData\Roaming\Godot\app_userdata\GaStorm\gastorm.json
func DataSave():
	UserData["HighScore"] = HighScore
	
	var SaveDat = JSON.	print(UserData, "\t")

	var f = File.new()	
	f.open("user://gastorm.json", File.WRITE)
	f.store_string(SaveDat)
	f.close()

func DataLoad():
	var f = File.new()	
	if f.file_exists("user://gastorm.json"):
		f.open("user://gastorm.json", File.READ)
		var dat = f.get_as_text()
		var ret = JSON.parse(dat)
		if ret.error == OK:
			#Convert Success
			#print("Score: %s"  %ret.result["HighScore"])
			var hs : int
			hs = ret.result["HighScore"]
			UserData["HighScore"] = hs
			HighScore = hs
		else:
			DataSave()
	else:
		DataSave()
