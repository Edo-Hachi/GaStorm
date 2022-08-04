extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite.play("default")	
	#print("Explode create")

func _on_AnimatedSprite_animation_finished() -> void:
	visible = false
	queue_free()
