#Path Follow 2d Enemy02
extends Node

var LoopType = GlobalNode.LoopType.Left01
var EnemyId	#Enemy Object instance ID
var LoopId	#Loop Object instance ID

var LoopPathObj : Object

func InitLoopEnemies(var enemy_id, var loop_id, var looptype):
	EnemyId = enemy_id
	LoopId = loop_id
	LoopType = looptype
	
	match LoopType:
		GlobalNode.LoopType.Left01:
			LoopPathObj = $LeftPath01/Path2D/PathFollow2D
		GlobalNode.LoopType.Right01:
			LoopPathObj = $RightPath01/Path2D/PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	LoopPathObj.unit_offset += 0.5	 * delta
	EnemyId.position = LoopPathObj.position
	EnemyId.rotation_degrees = LoopPathObj.rotation_degrees - 90
			
	if 1<= LoopPathObj.unit_offset:
		EnemyId.rotation_degrees = 0
		get_parent().LoopEnemyOver(EnemyId, LoopPathObj.position, EnemyId.MatrixWorldPos)
		EnemyId.SetEnemyState(1)
		
		
		queue_free()
