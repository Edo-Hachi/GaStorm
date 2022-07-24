extends Node

const ScreenWidth = 256
const ScreenHeight = 256

enum GState {TITLE, GAMEPLAY, GAMEOVER}
var GameState = GState.TITLE

var PlayerScore = 0

var GameMainSceneID = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
