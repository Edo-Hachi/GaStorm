#Guntret_Area2D

extends Area2D

var BulletScene = preload("res://src/GameMain/Guntret/Bullet_Area2D.tscn")
var PlayerExplodeScene = preload("res://src/GameMain/Explode/PlayerExplode.tscn")
var ExplodeScene = preload("res://src/GameMain/Particle/RectParticle.tscn")

export var Speed : float  = 200.0

var ShotBack = 0
var GuntretCrush = false
var GuntretCrushCount = 0

var GuntretRoll = 0

#コライダーのOnOff
func CollisionSetDisable(var param : bool):
	$CollisionShape2D.set_deferred("disabled", param)
	#Debug Mode
	if GlobalNode._DEBUG_ == true:
		$CollisionShape2D.set_deferred("disabled", true)


func _ready() -> void:
	GuntretCrush = false
	GuntretCrushCount=0
	$MzlFlush.visible = false
	
	#Debug Mode
	if GlobalNode._DEBUG_ == true:
		$CollisionShape2D.set_deferred("disabled", true)
	
	pass
	
func _process(delta: float) -> void:
	GuntretCrushCount+=1
	#自機フラッシュ処理
#	visible = false
#	#if sin(GuntretCrushCount/6)<0.5:
#	if sin(GuntretCrushCount/2)<0.2:
#		visible = true
#	return	

	
	#ゲームプレイ中でなおかつステージ実行中でなかったらリターンさせちゃう
	#if GlobalNode.GameState != GlobalNode.GState.GAMEPLAY:
	if GlobalNode.GameState == GlobalNode.GState.TITLE:
		return
	
	if GlobalNode.SubState == GlobalNode.SUBSTATE.GAMEOVER:
		return
	
	#自機クラッシュ中　
	if GuntretCrush == true:
		GuntretCrushCount+=1
		#自機フラッシュ処理
		visible = false
		if sin(GuntretCrushCount/2)<0.2:
		#if sin(GuntretCrushCount/6)<0.5:
			visible = true
		
		#if 180 < GuntretCrushCount:
		if 240 < GuntretCrushCount:
			GuntretCrush = false
			visible = true
			$CollisionShape2D.set_deferred("disabled", false)
			#Debug Mode
			if GlobalNode._DEBUG_ == true:
				$CollisionShape2D.set_deferred("disabled", true)

	#ステージクリアアニメーション中はキー入力キャンセル　
	if GlobalNode.SubState ==  GlobalNode.SUBSTATE.STAGE_CLEAR:
		$AnimatedSprite.animation = "Top"
		return
	if GlobalNode.SubState ==  GlobalNode.SUBSTATE.STAGE_CLEAR02:
		$AnimatedSprite.animation = "Top"
		return
	
	#Roll Recorvary	
	$AnimatedSprite.animation = "Top"
	if GuntretRoll < 0:
		GuntretRoll +=0.5
		$AnimatedSprite.animation = "Left"
	elif 0 <GuntretRoll:
		GuntretRoll -=0.5
		$AnimatedSprite.animation = "Right"
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector.x < 0:
		GuntretRoll -=1
		if GuntretRoll < -10:
			GuntretRoll = -10
	elif 0<input_vector.x:
		GuntretRoll +=1
		if 10<GuntretRoll:
			GuntretRoll=10
	
	position += input_vector* Speed * delta
		
	position.x = clamp(position.x, 16, GlobalNode.ScreenWidth - 16)
	position.y = clamp(position.y, 0, GlobalNode.ScreenHeight - 24)
	
	#自機の座標はグローバルに保存しておく（ボスから位置参照とかするかも）
	GlobalNode.GuntretPos = position
	
	$AnimatedSprite.offset.y = ShotBack
	if 0 <= ShotBack:
		ShotBack-=0.25
		
	#自機クラッシュ中は120フレームは撃てない
	if GuntretCrush == true && GuntretCrushCount<120:
		return

	if Input.is_action_pressed("Shot") or Input.get_action_strength("ui_accept"):
		if ShotBack <= 0:
			var Bullet = BulletScene.instance()
			Bullet.position = position
			get_parent().add_child(Bullet)
			
			$MzlFlush.visible = true
			$MzlFlush/AnimatedSprite.play()
			
			$ShotSound.play()
			
			ShotBack = 2

#frameFreeze(0.05, 1.0)
func frameFreeze(var timescale, var duration):
	Engine.time_scale = timescale
	yield(get_tree().create_timer(duration * timescale), "timeout")
	Engine.time_scale = 1.0
	

func _on_Guntret_area_entered(area: Area2D) -> void:
	if GuntretCrush == true:
		return
		
	#一時的にコライダーをOFFにする
	GuntretCrush = true
	GuntretCrushCount = 0
	$CollisionShape2D.set_deferred("disabled", true)

	$CrushSound.play()


	get_tree().paused = true
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().paused = false
	
	#Hit Stop
#	for i in range(0,5):
#		frameFreeze(0.02, 1.0)
	
	#画面揺らす
	get_parent().DispShakeStart(10, 50)

	var explode = ExplodeScene.instance()
	explode.SetParticle(position.x, position.y, 40)
	get_parent().add_child(explode)	

	visible = false
	
	get_parent().GuntretCrush()
