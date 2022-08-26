#Bullet_Area2D

extends Area2D

#var EnemyExplodeScene = preload("res://src/GameMain/Explode/EnemyExplode.tscn")

#var EnemyExplodeParticle = preload("res://src/GameMain/Particle/RectParticle.tscn") 
#var EnemyExplodeParticle = preload("res://src/GameMain/Particle/EnemyExplode.tscn") 

var Alive = true

export var Speed:float = 400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Alive = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= delta * Speed
	
	if position.y < -16:
		queue_free()

#Bullet Hit Enemy
func _on_Bullet_Area2D_area_entered(area: Area2D) -> void:
	
	if Alive == false:
		return
	
	#爆発生成
#	var explode = EnemyExplodeParticle.instance()
#	explode.SetParticle(position.x, position.y, 40)
#	get_parent().add_child(explode)	
#
#	#画面を揺らす
#	get_parent().DispShakeStart()
	
	#GlobalNode.DspShake = true
		
#	var explode = EnemyExplodeScene.instance()
#	explode.position = position
#	get_parent().add_child(explode)
	
	#自分をを消す
	visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	Alive = false
	#$CollisionShape2D.disabled = true
	queue_free()
