#Enemy_Area2D
extends Area2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
enum MoveTypeID  {
	Type01=0,
	Loop01L,
	Loop01R
}

var RootNode
var MoveType = MoveTypeID.Type01
var FlameCounter = 0	#随時更新　
var localCounter = 0	#タイマ計測用

var speed = 50

var MoveSeq = 0
#var velocity = Vector2()

var EnemyID

func SetEnemyId(var enemyid):
	EnemyID = enemyid
	#$AnimatedSprite.animation = "Green"
	$AnimatedSprite.animation = "Red"


func funcMoveType01(delta : float):
	var velocity = Vector2()
	
	match MoveSeq:
		0:
			position = position.move_toward(Vector2(200,250), delta * speed)
			velocity.x = 0
			velocity.y = 0.1


	#目標座標まで勝手に移動するやつ
	#position = position.move_toward(Vector2(0,0), delta * speed)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#MoveType = MoveTypeID.Type01
	#FlameCounter = 0
	#MoveSeq = 0
func SetMoveType(var movetype):
#	MoveType = movetype
	pass

func SetPositon(var x, var y):
	pass
#	position.x = x
#	position.y = y

			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#	FlameCounter+=1
#
#	match MoveType:
#		MoveTypeID.Type01:
#			funcMoveType01(delta)
	
	pass
