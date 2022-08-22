#Guntret_Area2D

extends Area2D

var BulletScene = preload("res://src/GameMain/Guntret/Bullet_Area2D.tscn")
var PlayerExplodeScene = preload("res://src/GameMain/Explode/PlayerExplode.tscn")


export var Speed : float  = 200.0

var ShotBack = 0


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	
	#debug
	#ゲームプレイ中でなおかつステージ実行中でなかったらリターンさせちゃう
	if GlobalNode.GameState != GlobalNode.GState.GAMEPLAY:
		return
	
	#ステージクリアアニメーション中はキー入力キャンセル　
	if GlobalNode.SubState ==  GlobalNode.SUBSTATE.STAGE_CLEAR:
		return
	if GlobalNode.SubState ==  GlobalNode.SUBSTATE.STAGE_CLEAR02:
		return
		
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	position += input_vector* Speed * delta
		
	position.x = clamp(position.x, 16, GlobalNode.ScreenWidth - 16)
	position.y = clamp(position.y, 0, GlobalNode.ScreenHeight - 32)
	
	$AnimatedSprite.offset.y = ShotBack
	if 0 <= ShotBack:
		ShotBack-=0.25
	
	var rot = rotation_degrees
		
	#Shot Bullet	
		#input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if Input.is_action_pressed("Shot") or Input.get_action_strength("ui_accept"):
		if ShotBack <= 0:
			var Bullet = BulletScene.instance()
			Bullet.position = position
			get_parent().add_child(Bullet)
			
			$ShotSound.play()
			
			ShotBack = 2


func _on_Guntret_area_entered(area: Area2D) -> void:
	print("Hit Enemy or Enemy Bullet")
	
	#visible = false
	#一時的にコライダーをOFFにする
	#数秒後に復活するようにするよてい(debug)
	$CollisionShape2D.set_deferred("disabled", true)
	
	var Explo = PlayerExplodeScene.instance()
	Explo.position = position
	get_parent().add_child(Explo)
