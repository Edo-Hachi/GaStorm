extends Node

const ScreenWidth = 256
const ScreenHeight = 256

enum GState {TITLE, GAMEPLAY, GAMEOVER}
var GameState = GState.TITLE

var PlayerScore = 0

var GameMainSceneID = 0

enum LoopType {Left01=0, Right01}
enum EnemyColor {Green=0, Red, Purple} 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func InitData(var fuga):
	PlayerScore = fuga
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
