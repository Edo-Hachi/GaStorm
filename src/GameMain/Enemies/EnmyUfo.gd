extends Area2D

var ExplodeParticle = preload("res://src/GameMain/Particle/EnemyExplode.tscn") 

export var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = -32
	position.y = 24
	$UfoSound.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta
	
	if GlobalNode.ScreenWidth + 32 <  position.x:
		queue_free()
	pass


func _on_EnemyUfo_area_entered(area: Area2D) -> void:
	$UfoCrush.play()

	var explode = ExplodeParticle.instance()
	#explode.position = position
	explode.SetParticle(position.x, position.y, 40)
	get_parent().add_child(explode)	

	queue_free()
