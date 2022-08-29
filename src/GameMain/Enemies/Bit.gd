extends Area2D

var Life = 3
var Hit = 0
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func CollisionDisabled(var param : bool):
	$CollisionShape2D.disabled = param

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Life = 3
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if 0 < Hit:
		if sin(Hit / 7) < 0.6:
			$AnimatedSprite.self_modulate = Color(0.9, 0, 0)
			#$AnimatedSprite.self_modulate = ColorN("white")
		else:
			$AnimatedSprite.self_modulate = Color(1,1,1)
		Hit-=1
	else:
		$AnimatedSprite.self_modulate = Color(1,1,1)


func _on_Bit_area_entered(area: Area2D) -> void:
#	print("Hit!!")
	Hit = 60
	Life -= 1
	$AnimatedSprite.self_modulate = Color(1,0,0)
	if Life <=0:
		visible = false
		#$CollisionShape2D.disabled = true
		$CollisionShape2D.set_deferred("disabled", true)
		GlobalNode.BossBitNum-=1
