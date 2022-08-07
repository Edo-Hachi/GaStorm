#Enemy_Area2D
extends Area2D

enum MoveTypeID  {
	Type01=0,
	Loop01L,
	Loop01R
}

var RootNode
var MoveType = MoveTypeID.Type01
var FlameCounter = 0	#随時更新　
var localCounter = 0	#タイマ計測用

var Speed = 10

var MoveSeq = 0

var EnemyID	#ObjectID
var Alive = true
var Matrix : Vector2	#隊列位置
var MatrixWorldPos : Vector2	#隊列位置実座標

#エネミーの行動ステート　
var EnemyState = GlobalNode.EnemyStateID.STAT_LOOP

func SetEnemyId(var enemyid):
	EnemyID = enemyid
	#$AnimatedSprite.animation = "Green"

func SetEnemyColor(var enemyColor : int):
	match enemyColor:
		GlobalNode.EnemyColor.Green:
			$AnimatedSprite.animation = "Green"
		GlobalNode.EnemyColor.Red:
			$AnimatedSprite.animation = "Red"
		GlobalNode.EnemyColor.Purple:
			$AnimatedSprite.animation = "Puraple"
			
func SetEnemyMatrix(var matrix : Vector2, var matri_xworld : Vector2):
	Matrix = matrix
	MatrixWorldPos = matri_xworld
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Alive = true
	pass

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

func _process(delta: float) -> void:
	
	match EnemyState:
		GlobalNode.EnemyStateID.STAT_LOOP:
			pass	#=0,	#現れた時のループ
		GlobalNode.EnemyStateID.STAT_GOHOME:	#ホームポジションへの移動
			#print("Call Go Home")
			position = position.move_toward(MatrixWorldPos, Speed * delta)
			rotation += 30
			Speed += 5
			
			if position == MatrixWorldPos:
				EnemyState = GlobalNode.EnemyStateID.STAT_FORMATION
				rotation = 0
				#get_parent().AppendEnemy(EnemyID)

				#print("Touchaku")
			pass
		GlobalNode.EnemyStateID.STAT_FORMATION:
			if GlobalNode.FormationMoveFlg == 0:
				return
			
			var matx : int = Matrix.x

			if GlobalNode.FormationMoveFlg == 1: #to outside
				match matx:
					0:
						position.x -= 20 * delta
					1:
						position.x -= 15 * delta
					2:
						position.x -= 10 * delta
					3:
						position.x -= 5 * delta
					4:
						position.x += 5 * delta
					5:
						position.x += 10 * delta
					6:
						position.x += 15 * delta
					7:
						position.x += 20 * delta
				
			elif GlobalNode.FormationMoveFlg == 2: #to_inner
				position = position.move_toward(MatrixWorldPos, 40 * delta)
			#rotation += 30
				#Speed += 5

#				match matx:
#					0:
#						position.x += 40 * delta
#					1:
#						position.x += 30 * delta
#					2:
#						position.x += 20 * delta
#					3:
#						position.x += 10 * delta
#					4:
#						position.x -= 10 * delta
#					5:
#						position.x -= 20 * delta
#					6:
#						position.x -= 30 * delta
#					7:
#						position.x -= 40 * delta
					
			pass
		GlobalNode.EnemyStateID.STAT_ATTACK:		#攻撃中
			pass

func _on_EnemyObject_area_entered(area: Area2D) -> void:
	#自機、ショットに当たった場合は自分（エネミー）削除フラグを立てる
	Alive = false	
	visible = false
	#コリジョンも不使用にする disabled = true
	$CollisionShape2D.set_deferred("disabled", true)

	get_parent().DeleteEnemy()


#func _on_EnemyObject_StatFormation() -> void:
#	SetEnemyState(EnemyStateID.STAT_FORMATION)
