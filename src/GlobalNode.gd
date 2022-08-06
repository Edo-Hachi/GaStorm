#星の速度調整、バックスクロール


#エネミーの左右移動　もうちょっとシンプルなコードに
#エネミーの硬さ

#音
#BGM



extends Node

const ScreenWidth = 256
const ScreenHeight = 256

enum GState {TITLE, GAMEPLAY, GAMEOVER}
var GameState = GState.TITLE

var PlayerScore = 0

var GameMainSceneID = 0

enum LoopType {Left01=0, Right01, Left02, Right02}
enum EnemyColor {Green=0, Red, Purple} 

enum EnemyStateID {
		STAT_LOOP=0,	#現れた時のループ
		STAT_GOHOME,	#ホームポジションへの移動
		STAT_FORMATION,
		STAT_ATTACK		#攻撃中
}

var FormationMoveFlg = 0 # hold 1=move_outside 2=move_inner


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func InitData(var fuga):
	PlayerScore = fuga
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
