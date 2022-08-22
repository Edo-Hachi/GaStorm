extends Node

const ScreenWidth = 256
const ScreenHeight = 256

#ゲームステート	
enum GState {TITLE = 0, GAMEPLAY, GAMEOVER}
var GameState : int  = GState.TITLE

#ゲームサブステート(GState.SUBSTATE)
enum SUBSTATE {STAGE_START=0, STAGE_PLAY, STAGE_CLEAR, STAGE_CLEAR02}
var SubState : int = SUBSTATE.STAGE_START

var PlayerScore = 0

var GameMainSceneID = 0

enum LoopType {Left01=0, Right01, Left02, Right02, RevStgLeft01, RevStgRight01}
enum EnemyColor {Green=0, Red, Purple} 

#エネミーの行動ステート
enum EnemyStateID {
		STAT_LOOP=0,	#現れた時のループ
		STAT_GOHOME,	#ホームポジションへの移動
		STAT_FORMATION,
		STAT_ATTACK		#攻撃中
}

#隊列を組んでいる時のエネミーの動作ステート
var EnemyFormationFinished = false	#Loop完了後に全エネミーがホームポジションに戻るとtrueになる　

#エネミーのホームポジションアニメフラグ
enum EnFrmStateID{
	STOP = 0,
	HOME,
	OUTER
}
var EnFrmState = EnFrmStateID.STOP

#Color Name Like a Pico8 Colors)
var ColorName = ["black", "navyblue", "maroon", "darkgreen", "brown", "darkolivegreen", "darkgray", "cornsilk", "red", "darkorange", "yellow", "green",
					 "deepskyblue",  "dimgray", "hotpink",  "lightsalmon"]
var Colormax = ColorName.size()

#スクロールリバース面フラグ trueになってたらリバース面処理中
var BgScrollReverse = false
#var DspShake = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func InitData(var fuga):
	PlayerScore = fuga
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
