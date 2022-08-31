extends Area2D

var BitScn = preload("res://src/GameMain/Enemies/Bit.tscn")
var BULLET_TSCN = preload("res://src/GameMain/Enemies/EnemyBullet.tscn")

var EXPBOSS_TSCN = preload("res://src/GameMain/Particle/BossExplode.tscn")
var EXCP_MINI_TSCN =preload("res://src/GameMain/Particle/EnemyExplode.tscn")


#ビットのアニメーション情報-----------------------------
const rad30 : float = 0.52359
const BitMax = 12 #30度ごとに12個
var BitList = []	#クラス格納リスト
var BitD = 0.0	#円環上座標
var BitR = 1	#円環版権
#ビットのアニメーション情報-----------------------------

#ボスの行動ステート------------------------------------
var BossState
enum State{State01 = 0, State02, State03, State04, StateDead}
#ボスの行動ステート------------------------------------

#ボスの行動ステート01------------------------------------
var State01Speed= 130 #移動速度　
export var Stg01Scl :float = 25 #t籠城時のスケール　
var Stg01TgtScl = 1 #登場シーンが終わったときのスケール

var BossLife = 10
var BossExpodeCount = 30

#ボスの行動ステート03------------------------------------
var MoveDir = 0 #0=右 1=左　
#ボスの行動ステート03------------------------------------

#30度単位でビットを出すよ
func InitBit():
	for i in range(BitMax):
		var tmp = BitScn.instance()
		BitList.append(tmp)
		get_parent().add_child(tmp)

#ビットのアニメーション
func DrawBit(var r):
	for i in range(BitMax):
		BitList[i].position = Vector2(sin(rad30 * i + BitD) * r,
										cos(rad30 * i + BitD) * r) + position

#ビット方向に弾をばらまく
func ShotEnemyBullet02(var pos):
	for i in range(BitMax):
		var ScnBullet = BULLET_TSCN.instance()
		ScnBullet.SetPos(pos)
#		ScnBullet.SetToword(BitList[i].position, randi()%100+50)
		ScnBullet.SetToword(BitList[i].position, 100)
		get_parent().add_child(ScnBullet)

#ビット方向に弾をばらまく
func ShotEnemyBullet03(var pos):
	for i in range(BitMax):
		var ScnBullet = BULLET_TSCN.instance()
		ScnBullet.SetPos(pos)
		ScnBullet.SetToword(BitList[i].position, randi()%100+50)
#		ScnBullet.SetToword(BitList[i].position, 100)
		get_parent().add_child(ScnBullet)


#出現ステート
func State01(var delta:float) -> bool:

#最終的には100くらいの速度で
#	Stg01Scl += (Stg01TgtScl - Stg01Scl) / 100
	Stg01Scl += (Stg01TgtScl - Stg01Scl) / 10

	if 1<= Stg01Scl:
		Stg01Scl -= Stg01Scl * delta
		$AnimatedSprite.scale.x = Stg01Scl
		$AnimatedSprite.scale.y = Stg01Scl
	
	var ToPos = Vector2(GlobalNode.ScreenWidth  / 2, 64)
	position = position.move_toward(ToPos, State01Speed * delta)
	
	#目標地点に到着＆スケールが1になった
	if position == ToPos && Stg01Scl < 1:
		Stg01Scl = 1	#スケールを1に固定	
		return true
	return false

#-------------------------------------------------------
#func State02(var delta:float) -> bool:
#	BitD += 2 * delta #回転処理
#
#	if BitR < 40: #円の半径を40まで
#		BitR += 20 * delta
#		return false
#	elif 40 <= BitR:
#		#yield(get_tree().create_timer(1), "timeout")
#		#BitのコライダーをOnにする
#		for i in range(BitMax):
#			BitList[i].CollisionDisabled(false)
#		return true
#
#	return false
#-------------------------------------------------------

func _ready() -> void:
	BossState = State.State01

	position.x = GlobalNode.ScreenWidth /2
	position.y = GlobalNode.ScreenHeight - 128
	GlobalNode.BossBitNum = 0
		
func _process(delta: float) -> void:
	
	match BossState:
		#画面外からの登場　
		State.State01:
			if State01(delta) == true:
				BossState = State.State02
				InitBit()
				return
		
		#ビットの表示、表示半径を大きくしていく	
		State.State02:
			BitD += 2 * delta #回転処理
			if BitR < 40: #円の半径を40まで
				BitR += 20 * delta
			elif 40 <= BitR:
				yield(get_tree().create_timer(1), "timeout")
				#BitのコライダーをOnにする
				for i in range(BitMax):
					BitList[i].CollisionDisabled(false)
					#BitList[i].set_deferred("disabled", false)
				#生きているビットの数を設定　
				GlobalNode.BossBitNum = BitMax
				#次のステートへ
				BossState = State.State03
			DrawBit(BitR)
		
		#ビットをつけたまま左右に移動＆攻撃
		State.State03:
			#print(GlobalNode.BossBitNum)
			BitD += 2 * delta
			if MoveDir==0:
				position.x += 100 * delta
				if 200 < position.x:
					MoveDir = 1
			elif MoveDir == 1:
				position.x -= 100 * delta
				if position.x < 50:
					MoveDir = 0
			
			DrawBit(BitR)
			
#			if randi() % 50 == 1:
			if randi() % 500 == 1:
				get_parent().ShotEnemyBullet(position, 0) #真下狙い
				get_parent().ShotEnemyBullet(position, 1) #自機狙い
				
				#内部実装
				ShotEnemyBullet02(position)
			
			#ビットがすべて破壊されたらステート４へ移行する　
			if GlobalNode.BossBitNum ==0:
				BossState = State.State04
				#コリジョンをONに（やっと攻撃できるぞ）
				$CollisionShape2D.disabled = false
		
		#最終形態	----------------------------------------------------------
		State.State04:
			#移動
			if MoveDir==0:
				position.x += 200 * delta
				if 200 < position.x:
					MoveDir = 1
			elif MoveDir == 1:
				position.x -= 200 * delta
				if position.x < 50:
					MoveDir = 0
			
			#攻撃
#			if randi() % 40 == 1:
			if randi() % 400 == 1:
				get_parent().ShotEnemyBullet(position, 1) #自機狙い
				get_parent().ShotEnemyBullet(position, 1) #自機狙い
				#内部実装
				ShotEnemyBullet02(position)
			
			if randi() % 500 == 1:
#			if randi() % 50 == 1:
				get_parent().ShotEnemyBullet(position, 1) #自機狙い
				get_parent().ShotEnemyBullet(position, 1) #自機狙い
				ShotEnemyBullet03(position)

			#ダメージに応じた色変更	
			match BossLife / 2:
				5:
					$AnimatedSprite.self_modulate = Color(1, 1, 1)
				4:
					$AnimatedSprite.self_modulate = Color(0.9, 0, 0)
				3:
					$AnimatedSprite.self_modulate = Color(0.6, 0, 0)
				2:
					$AnimatedSprite.self_modulate = Color(0.4, 0, 0)
				1:
					$AnimatedSprite.self_modulate = Color(0.2, 0, 0)
		
		#Boss Dead---------------------------------------------------------------
		State.StateDead:
			var ToPos = Vector2(GlobalNode.ScreenWidth  / 2, 64)
			position = position.move_toward(ToPos, State01Speed * delta)
				
			pass
	update()
	pass

#バリア表示	
func _draw():
	var rect : Rect2
	if BossState == State.State03:
		if 0<GlobalNode.BossBitNum:
			draw_circle(Vector2(0,0), 20, ColorN("yellow",0.3))

func _on_BossEnemy_area_entered(area: Area2D) -> void:
	var explo = EXCP_MINI_TSCN.instance()
	explo.SetParticle(position.x, position.y, 100)
	get_parent().add_child(explo)
	
	
	#print("Boss Hit")
	BossLife -= 1
	
	#BossLife -= 10
	
	#$CollisionShape2D.disabled(true)
	#$CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
#	$CollisionShape2D.disabled = true
	$Timer.start()
	#print("Timer Start")
	
	#print(BossLife)
	if BossLife <= 0:
		#print("Boss Dead")
		BossState = State.StateDead
		$TimerExplode.start()


#1秒単位で飛んでくるタイマ
func _on_Timer_timeout() -> void:
	#print("Timer Called ")
	$CollisionShape2D.set_deferred("disabled", false)
	#$Timer.stop()
	pass # Replace with function body.


#ボスの爆発タイミング用タイマ
func _on_TimerExplode_timeout() -> void:
		
	var explo = EXPBOSS_TSCN.instance()
	var ofs = rand_range(-50, 50)

	explo.SetParticle(position.x + ofs, position.y + ofs, BossExpodeCount)
	get_parent().add_child(explo)
	
	BossExpodeCount-=1

	if BossExpodeCount < 10:
		visible = false
	
	if BossExpodeCount < 0:
		get_parent().GameClear()
		#print("Boss End")
		queue_free()
		return
