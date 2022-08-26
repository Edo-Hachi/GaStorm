extends Area2D

#var velocity : Vector2
#var degrees = 45
var Speed = 100
var velocity : Vector2
var ToPosition : Vector2

const DEG = 0	#真下へ
const TOW = 1	#狙った座標へ　

var MoveMode = DEG

# Called when the node enters the scene tree for the first time.
#出現位置設定
func SetPos(var pos : Vector2):
	position = pos

#出現位置からの角度での移動
func SetDegrees(var degrs, var spd):
	rotation_degrees = degrs
	Speed = spd
	MoveMode = DEG

#出現位置から目標座標への移動
func SetToword(var tow : Vector2, var spd):
	velocity = Vector2((tow.x - position.x), (tow.y - position.y))
	velocity = velocity.normalized()
	Speed = spd
	MoveMode = TOW	

#SpeedSet
func SetSpeed(var spd):
	Speed = spd

func _ready() -> void:
	#移動角度設定
	rotation_degrees = 90

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#スプライト回転アニメーション　　
	$AnimatedSprite.rotation_degrees +=10

	match MoveMode:
		DEG:
			position += Vector2(1,0).rotated(rotation) * Speed * delta
		TOW:
			position += velocity * Speed * delta
	
	#画面外に出たらオブジェクト破棄
	var quefree = false
	if position.y < -32 or GlobalNode.ScreenHeight + 32 < position.y:
		quefree = true
	if position.x < -32 or GlobalNode.ScreenWidth + 32 < position.x:
		quefree = true

	if quefree == true:
		queue_free()
