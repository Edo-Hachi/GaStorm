#Enemy_Area2D
extends Area2D


#signal StatFormation()


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
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
#enum EnemyStateID {
#		STAT_LOOP=0,	#現れた時のループ
#		STAT_GOHOME=1,	#ホームポジションへの移動
#		STAT_FORMATION = 2,
#		STAT_ATTACK=3		#攻撃中
#	}
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
	print("SetEnemyState Called")
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

				#print("Touchaku")
			pass
		GlobalNode.EnemyStateID.STAT_FORMATION:
			#print("Formation Mode Now")
			pass
		GlobalNode.EnemyStateID.STAT_ATTACK:		#攻撃中
			pass

func _on_EnemyObject_area_entered(area: Area2D) -> void:
	#自機、ショットに当たった場合は自分（エネミー）削除フラグを立てる
	Alive = false	
	visible = false
	#コリジョンも不使用にする disabled = true
	$CollisionShape2D.set_deferred("disabled", true)


#func _on_EnemyObject_StatFormation() -> void:
#	SetEnemyState(EnemyStateID.STAT_FORMATION)
