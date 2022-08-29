extends Area2D

var BitScn = preload("res://src/GameMain/Enemies/Bit.tscn")
var BULLET_TSCN = preload("res://src/GameMain/Enemies/EnemyBullet.tscn")

#ビットのアニメーション情報-----------------------------
const rad30 : float = 0.52359
const BitMax = 12 #30度ごとに12個
var BitList = []	#クラス格納リスト
var BitD = 0.0	#円環上座標
var BitR = 1	#円環版権
#ビットのアニメーション情報-----------------------------

#ボスの行動ステート------------------------------------
var BossState
enum State{State01 = 0, State02, State03, State04}
#ボスの行動ステート------------------------------------

#ボスの行動ステート01------------------------------------
var State01Speed= 130 #移動速度　
export var Stg01Scl :float = 25 #t籠城時のスケール　
var Stg01TgtScl = 1 #登場シーンが終わったときのスケール
 

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
		ScnBullet.SetToword(BitList[i].position, 100)
		get_parent().add_child(ScnBullet)


#出現ステート
func State01(delta:float) -> bool:

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
	

func _ready() -> void:
	BossState = State.State01

	position.x = GlobalNode.ScreenWidth /2
	position.y = GlobalNode.ScreenHeight - 128
	GlobalNode.BossBitNum = 0
		
func _process(delta: float) -> void:
	
	match BossState:
		State.State01:
			if State01(delta) == true:
				BossState = State.State02
				InitBit()
				return
				
		State.State02:
			#position.x += 10 * delta
			BitD += 2 * delta
			if BitR < 40:
				BitR += 20 * delta
			elif 40 <= BitR:
				yield(get_tree().create_timer(1), "timeout")
				BossState = State.State03
				
				#BitのコライダーをOnにする
				for i in range(BitMax):
					BitList[i].CollisionDisabled(false)
					#BitList[i].set_deferred("disabled", false)
			DrawBit(BitR)
			
			#生きているビットの数を設定　
			GlobalNode.BossBitNum = BitMax
			
		
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
			
			if randi() % 50 == 1:
				get_parent().ShotEnemyBullet(position, 0) #真下狙い
				get_parent().ShotEnemyBullet(position, 1) #自機狙い
				
				#内部実装
				ShotEnemyBullet02(position)
		
			if GlobalNode.BossBitNum ==0:
				BossState = State.State04
		
		#最終形態	　
		State.State04:
			if MoveDir==0:
				position.x += 250 * delta
				if 200 < position.x:
					MoveDir = 1
			elif MoveDir == 1:
				position.x -= 250 * delta
				if position.x < 50:
					MoveDir = 0
			if randi() % 30 == 1:
				get_parent().ShotEnemyBullet(position, 0) #真下狙い
				get_parent().ShotEnemyBullet(position, 1) #自機狙い
				get_parent().ShotEnemyBullet(position, 1) #自機狙い
				#内部実装
				ShotEnemyBullet02(position)
			$AnimatedSprite.self_modulate = Color(0.9, 0, 0)


	update()

func _draw():
	var rect : Rect2
	if BossState == State.State03:
		if 0<GlobalNode.BossBitNum:
			draw_circle(Vector2(0,0), 20, ColorN("yellow",0.3))
		
