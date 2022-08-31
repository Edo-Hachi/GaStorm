extends Area2D

var Velocity = Vector2(0,1)
var Speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite.rotation_degrees += 5
	
	position += Velocity * Speed * delta
	
	#画面外に出たらオブジェクト破棄
	var quefree = false
	if position.y < -32 or GlobalNode.ScreenHeight + 32 < position.y:
		quefree = true
	if position.x < -32 or GlobalNode.ScreenWidth + 32 < position.x:
		quefree = true

	if quefree == true:
		queue_free()
