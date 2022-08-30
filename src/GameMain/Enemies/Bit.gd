extends Area2D

var REFRECT = preload("res://src/GameMain/Particle/EnemyRefrect.tscn")
var EXPLODE = preload("res://src/GameMain/Particle/EnemyExplode.tscn")

var Life = 3	#ビットのライフ数
var Hit = 0

func CollisionDisabled(var param : bool):
	$CollisionShape2D.disabled = param

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Life = 4
	pass # Replace with function body.


func _process(delta: float) -> void:
	var ColorRed = 0.3
	match Life:
		4:	#無傷
			$AnimatedSprite.self_modulate = Color(1, 1, 1)
		3:
			$AnimatedSprite.self_modulate = Color(0.3, 0, 0)
		2:
			$AnimatedSprite.self_modulate = Color(0.5, 0, 0)
		1: #壊れる直前
			$AnimatedSprite.self_modulate = Color(0.9, 0, 0)
	pass

#ビットがたまに当たった
func _on_Bit_area_entered(area: Area2D) -> void:
	Life -= 1
	var ref = REFRECT.instance()
	ref.SetParticle(position.x, position.y, 20)
	get_parent().add_child(ref)
		
#		$SoundRefrect.play()
	
	
	#Lifeが0でビット消す
	if Life <=0:
		visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		GlobalNode.BossBitNum-=1
		
		var Exp = EXPLODE.instance()
		Exp.SetParticle(position.x, position.y, 40)
		get_parent().add_child(Exp)
