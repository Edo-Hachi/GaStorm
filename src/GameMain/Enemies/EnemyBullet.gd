extends Area2D

#var velocity : Vector2
#var degrees = 45
var Speed = 100
var velocity : Vector2
var ToPosition : Vector2

const DEG = 0
const TOW = 1

var MoveMode = DEG

# Called when the node enters the scene tree for the first time.
#出現位置設定
func SetPos(var pos : Vector2):
	position = pos

#出現位置からの角度での移動
func SetDegrees(var degrs):
	rotation_degrees = degrs
	MoveMode = DEG

#出現位置から目標座標への移動
func SetToword(var tow : Vector2):
	velocity = Vector2((tow.x - position.x), (tow.y - position.y))
	velocity = velocity.normalized()
	MoveMode = TOW	

#SpeedSet
func SetSpeed(var spd):
	Speed = spd

func _ready() -> void:
	#移動角度設定
	rotation_degrees = 90


	#debug
	#position.x = 100
	#position.y = 100
	
	#debug----------------
	#ToPosition.x = 50
	#ToPosition.y = 250
	#velocity = Vector2((ToPosition.x - position.x), (ToPosition.y - position.y))
	#debug----------------
	

	#velocity = velocity.normalized()
	
	
	#velocity = Vector2(100,100).rotated(0)
	#pass # Replace with function body.


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
