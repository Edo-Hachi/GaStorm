#Path Follow 2d Enemy02
extends Node

var LoopType = GlobalNode.LoopType.Left01
var EnemyId	#Enemy Object instance ID
var LoopId	#Loop Object instance ID

var LoopPathObj : Object
var UnitOffset : float = 0.5

#func SetUnifOffset(var uofs : float):
#	UnitOffset = uofs

func InitLoopEnemies(var enemy_id, var loop_id, var looptype, var uofs):
	EnemyId = enemy_id
	LoopId = loop_id
	LoopType = looptype
	UnitOffset = uofs
	
	match LoopType:
		GlobalNode.LoopType.Left01:
			LoopPathObj = $LeftPath01/Path2D/PathFollow2D
		GlobalNode.LoopType.Right01:
			LoopPathObj = $RightPath01/Path2D/PathFollow2D
		GlobalNode.LoopType.Left02:
			LoopPathObj = $LeftPath02/Path2D/PathFollow2D
		GlobalNode.LoopType.Right02:
			LoopPathObj = $RightPath02/Path2D/PathFollow2D
		GlobalNode.LoopType.RevStgLeft01:
			LoopPathObj = $RevStgLeft01/Path2D/PathFollow2D
		GlobalNode.LoopType.RevStgRight01:
			LoopPathObj = $RevStgRight01/Path2D/PathFollow2D
		GlobalNode.LoopType.RevStgLeft02:
			LoopPathObj = $RevStgLeft02/Path2D/PathFollow2D	
		GlobalNode.LoopType.RevStgRight02:
			LoopPathObj = $RevStgRight02/Path2D/PathFollow2D	
		#_:
		#	LoopPathObj= null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#LoopPathObj = null
	#UnitOffset = 0.5
	pass

func _process(delta: float) -> void:
	
	LoopPathObj.unit_offset += (UnitOffset * delta)
	EnemyId.position = LoopPathObj.position
	EnemyId.rotation_degrees = LoopPathObj.rotation_degrees - 90
	
	
	if 1<= LoopPathObj.unit_offset:
		EnemyId.rotation_degrees = 0

		get_parent().LoopEnemyOver(EnemyId, LoopPathObj.position, EnemyId.MatrixWorldPos)
		
		queue_free()
	
	#print(LoopPathObj.unit_offset)
