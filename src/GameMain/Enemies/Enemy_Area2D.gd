#Enemy_Area2D
extends Area2D

var EnemyExplodeParticle = preload("res://src/GameMain/Particle/EnemyExplode.tscn") 

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
			Life = 0
		GlobalNode.EnemyColor.Red:
			$AnimatedSprite.animation = "Red"
			Life = 0
		GlobalNode.EnemyColor.Purple:
			$AnimatedSprite.animation = "Puraple"
			Life = 0
			
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
	#EnemyState = EnemyStateID.STAT_FORMATION

#ホームポジションへの移動完了状態を返す
#HomePosition = 0  Move = 1
#func GetHomeState() -> int:
#	return ReturnToHomeState

#フォーメーションアニメーション開始（GameMainでの全エネミーホームポジション達成条件成立から投げられてくる）
func ActivateFormation():
	EnemyState = GlobalNode.EnemyStateID.STAT_FORMATION
	pass

func _process(delta: float) -> void:
	
#var EnemyFormation # hold 1=move_outside 2=move_inner
#enum EnemyFormationState {MOVE_STOP = 0, MOVE_LOOP, MOVE_OUTSIDE, MOVE_INSIDE, ATTACK}

	
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
			var x1 = 12
			var x2 = 8
			var x3 = 4
			var x4 = 2
			
			#GlobalNode.EnemyFormationFinished == true フォーメーションアニメーション実行
			if GlobalNode.EnemyFormationFinished == true:
#				if GlobalNode.EnFrmState != GlobalNode.EnFrmStateID.STOP:

				if GlobalNode.EnFrmState == GlobalNode.EnFrmStateID.OUTER:
					#print("To Outer")
#					position.x += 10 * delta
					match int(Matrix.x):
						0:
							position.x -= x1 * delta
							position.y += x1 * delta
						1:
							position.x -= x2 * delta
							position.y += x2 * delta
						2:
							position.x -= x3 * delta
							position.y += x3 * delta
						3:
							position.x -= x4 * delta
							position.y += x4 * delta
						4:
							position.x += x4 * delta
							position.y += x4 * delta
						5:
							position.x += x3 * delta
							position.y += x3 * delta
						6:
							position.x += x2 * delta
							position.y += x2 * delta
						7:
							position.x += x1 * delta
							position.y += x1 * delta
					pass

				if GlobalNode.EnFrmState == GlobalNode.EnFrmStateID.HOME:
					#print("To Home")
					position = position.move_toward(MatrixWorldPos, 25 * delta)
					pass
					#print("Enemy Form Animation Active")
#				if GlobalNode.EnFrmState == GlobalNode.EnFrmStateID.HOME:
#					#print("Enemy Sub State Home")
#					#GlobalNode.EnFrmState = GlobalNode.EnFrmStateID.OUTER:
#					pass
#				elif GlobalNode.EnFrmState == GlobalNode.EnFrmStateID.OUTER:
					#print("Enemy Sub State Outer")

			#if GlobalNode.EnFrmState == HOME:
				
#			if GlobalNode.EnemyFormation == 0:
#				return
#
#			var matx : int = Matrix.x
#
#			#print ("Enemy Move", GlobalNode.EnemyFormation)
#
#			if GlobalNode.EnemyFormation == GlobalNode.EnemyFormationState.MOVE_OUTSIDE: #to outside
#				match matx:
#					0:
#						position.x -= 20 * delta
#					1:
#						position.x -= 15 * delta
#					2:
#						position.x -= 10 * delta
#					3:
#						position.x -= 5 * delta
#					4:
#						position.x += 5 * delta
#					5:
#						position.x += 10 * delta
#					6:
#						position.x += 15 * delta
#					7:
#						position.x += 20 * delta
				
					
			pass
		GlobalNode.EnemyStateID.STAT_ATTACK:		#攻撃中
			pass

func _on_EnemyObject_area_entered(area: Area2D) -> void:
	#自機、ショットに当たった場合は自分（エネミー）削除フラグを立てる
	Life -= 1
	if Life < 0:
		
		#Enemy is Dead	
		var explode = EnemyExplodeParticle.instance()
		explode.SetParticle(position.x, position.y, 40)
		get_parent().add_child(explode)	
		
		#画面を揺らす
		get_parent().DispShakeStart()		
		
		Alive = false	
		visible = false
		#コリジョンも不使用にする disabled = true
		$CollisionShape2D.set_deferred("disabled", true)

		get_parent().DeleteEnemy()


#func _on_EnemyObject_StatFormation() -> void:
#	SetEnemyState(EnemyStateID.STAT_FORMATION)
