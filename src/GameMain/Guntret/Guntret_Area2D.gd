#Guntret_Area2D

extends Area2D

var BulletScene = preload("res://src/GameMain/Guntret/Bullet_Area2D.tscn")

export var Speed : float  = 300.0

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("Move_Right"):
		direction.x += 1	
	
	if Input.is_action_pressed("Move_Left"):
		direction.x -= 1

	if Input.is_action_pressed("Move_Up"):
		direction.y -= 1

	if Input.is_action_pressed("Move_Down"):
		direction.y += 1
		
	direction = direction.normalized()
	position += direction * Speed * delta
	position.x = clamp(position.x, 16, GlobalNode.ScreenWidth - 16)
	position.y = clamp(position.y, 0, GlobalNode.ScreenHeight - 32)
	
	var rot = rotation_degrees
		
	#Shot Bullet	
	if Input.is_action_pressed("Shot"):
		var Bullet = BulletScene.instance()
		Bullet.position = position
		get_parent().add_child(Bullet)
