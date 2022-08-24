#Enemy_Area2D
extends Area2D

var EnemyExplodeParticle = preload("res://src/GameMain/Particle/EnemyExplode.tscn") 
var EnemyRefrectParticle = preload("res://src/GameMain/Particle/EnemyRefrect.tscn") 

enum MoveTypeID  {
	Type01=0,
	Loop01L,
	Loop01R
}

var RootNode
var MoveType = MoveTypeID.Type01
var FlameCounter = 0	#随時更新　
var localCounter = 0	#タイマ計測用

#var Speed = 150
var Speed = 20

var MoveSeq = 0

var EnemyID	#ObjectID
var Alive = true
var Matrix : Vector2	#隊列位置
var MatrixWorldPos : Vector2	#隊列位置実座標
var Life : int = 1
var ScoreMulti = 1	#スコア計算時の係数
var BackScroll = false

#var ReturnToHomeState = 0

#エネミーの行動ステート
var EnemyState = GlobalNode.EnemyStateID.STAT_LOOP

func SetEnemyId(var enemyid):
	EnemyID = enemyid
	#$AnimatedSprite.animation = "Green"

func SetEnemyColor(var enemyColor : int):
	match enemyColor:
		GlobalNode.EnemyColor.Green:
			$AnimatedSprite.animation = "Green"
			Life = 1
			ScoreMulti = Life
		GlobalNode.EnemyColor.Red:
			$AnimatedSprite.animation = "Red"
			Life = 1
			ScoreMulti = Life
		GlobalNode.EnemyColor.Purple:
			$AnimatedSprite.animation = "Puraple"
			Life = 1
			ScoreMulti = Life
			
func SetEnemyMatrix(var matrix : Vector2, var matri_xworld : Vector2):
	Matrix = matrix
	MatrixWorldPos = matri_xworld
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Alive = true
	#ReturnToHomeState = 1	#ホームポジションに戻ってない　

func SetMoveType(var movetype):
#	MoveType = movetype
	pass

func SetPositon(var x, var y):
	pass
#	position.x = x
#	position.y = y

func SetEnemyState(var stat):
	#print("SetEnemyState Called")
	EnemyState = stat
	
#	if stat == GlobalNode.EnemyStateID.STAT_ATTACK:
#		print("Attack Modde")

	#EnemyState = EnemyStateID.STAT_FORMATION

#ホームポジションへの移動完了状態を返す
#HomePosition = 0  Move = 1
#func GetHomeState() -> int:
#	return ReturnToHomeState

#フォーメーションアニメーション開始（GameMainでの全エネミーホームポジション達成条件成立から投げられてくる）
func ActivateFormation():
	EnemyState = GlobalNode.EnemyStateID.STAT_FORMATION
	pass

func EnemyFormationMove(delta: float):
	var x1 = 12 * 3
	var x2 = 8 * 3
	var x3 = 4 * 3
	var x4 = 2 * 3
	
	if GlobalNode.EnemyFormationFinished == true:
		if GlobalNode.EnFrmState == GlobalNode.EnFrmStateID.OUTER:
			match int(Matrix.x):
				0:
					position.x -= x1 * delta
					position.y += x1/2 * delta
				1:
					position.x -= x2 * delta
					position.y += x2/2 * delta
				2:
					position.x -= x3 * delta
					position.y += x3/2 * delta
				3:
					position.x -= x4 * delta
					position.y += x4/2 * delta
				4:
					position.x += x4 * delta
					position.y += x4/2 * delta
				5:
					position.x += x3 * delta
					position.y += x3/2 * delta
				6:
					position.x += x2 * delta
					position.y += x2/2 * delta
				7:
					position.x += x1 * delta
					position.y += x1/2 * delta
			pass

		if GlobalNode.EnFrmState == GlobalNode.EnFrmStateID.HOME:
			position = position.move_toward(MatrixWorldPos, 40 * delta)
			pass

func _process(delta: float) -> void:
	match EnemyState:
		#出現ループ中処理
		GlobalNode.EnemyStateID.STAT_LOOP:
			#適当に弾をばらまく
			if 10 < position.y:
				if randi() % 100 == 0:
					get_parent().ShotEnemyBullet(position)
			
		#ホームポジションへの移動
		GlobalNode.EnemyStateID.STAT_GOHOME:
			#print("Call Go Home")
			position = position.move_toward(MatrixWorldPos, Speed * delta)
			rotation += 30
			#if 30 <= Speed:
			Speed += 5
				#Speed -= 2
			
			if position == MatrixWorldPos:
				#EnemyState = GlobalNode.EnemyStateID.STAT_FORMATION
				rotation = 0
				
				#フォーメーションアニメ実行ステートに移行
				EnemyState = GlobalNode.EnemyStateID.STAT_FORMATION
				return
				pass
				#ReturnToHomeState = 0	#ホームポジションに戻ったら0セット
				
				#get_parent().AppendEnemy(EnemyID)

				#print("Touchaku")
		
		#隊列編成時処理
		
		GlobalNode.EnemyStateID.STAT_FORMATION:
			EnemyFormationMove(delta)
			pass
		
		GlobalNode.EnemyStateID.STAT_ATTACK:		#攻撃中
			FlameCounter+=1

			EnemyFormationMove(delta)
			#$AnimatedSprite.offset.y += 5 *
			$AnimatedSprite.offset.y += 20 * delta
			if 0 <= FlameCounter and FlameCounter < 30:
				#print("30:",FlameCounter)
				$AnimatedSprite.self_modulate = Color(1,0,0)
				#$AnimatedSprite.offset.y +=2 * delta
			elif 30<=FlameCounter and FlameCounter < 60:
				#$AnimatedSprite.position +=2 * delta
				#print("60:", FlameCounter)
				$AnimatedSprite.self_modulate = Color(1,1,1)
				
			if 60 < FlameCounter:
				FlameCounter = 0

			pass

func _on_EnemyObject_area_entered(area: Area2D) -> void:
	#自機、ショットに当たった場合は自分（エネミー）削除フラグを立てる
	Life -= 1
	
	if 0<= Life:
		var ref = EnemyRefrectParticle.instance()
		ref.SetParticle(position.x, position.y, 20)
		#func SetParticle(var x, var y, var prtmax):
		get_parent().add_child(ref)
		
		$SoundRefrect.play()
	
	elif Life < 0:
		
		#Enemy is Dead	
		var explode = EnemyExplodeParticle.instance()
		explode.SetParticle(position.x, position.y, 40)
		get_parent().add_child(explode)	
		
		$SoundExplode.play()
			
		#画面を揺らす
		get_parent().DispShakeStart(3,10)		
		
		Alive = false	
		visible = false
		
		GlobalNode.PlayerScore += 100 * ScoreMulti

		#コリジョンも不使用にする disabled = true
		$CollisionShape2D.set_deferred("disabled", true)

		get_parent().DeleteEnemy()


#func _on_EnemyObject_StatFormation() -> void:
#	SetEnemyState(EnemyStateID.STAT_FORMATION)
