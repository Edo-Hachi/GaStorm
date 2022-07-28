#Bullet_Area2D

extends Area2D

var EnemyExplodeScene = preload("res://src/GameMain/Explode/EnemyExplode.tscn")

export var Speed:float = 400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= delta * Speed
	

#Hit
func _on_Bullet_Area2D_area_entered(area: Area2D) -> void:
	var explode = EnemyExplodeScene.instance()
	explode.position = position
	get_parent().add_child(explode)
	
	#自分をを消す
	visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	#$CollisionShape2D.disabled = true
	queue_free()
