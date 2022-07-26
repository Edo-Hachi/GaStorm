#PathFollowEnemies
extends Node2D

enum LoopTypeId {Left01=0, Right01=1}

var LoopType = LoopTypeId.Left01
var EnemyId
var LoopId


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LeftPath01.visible = false
	$RightPath01.visible = false
	pass
	

func SetLoopType(var looptype):
	LoopType = looptype
	match LoopType:
			
		LoopTypeId.Left01:
			print("Loop Left 01Ready")
			#$LeftPath01.visible = true
			
		LoopTypeId.Right01:
			print("Loop right01 Ready")
			#$RightPath01.visible = true

func SetEnemyId(var enid):
	EnemyId= enid

func SetLoopId(var lpid):
	LoopId = lpid
	
func _process(delta: float) -> void:
	match LoopType:
		LoopTypeId.Left01:
			#print("LoopType01Move")
			$LeftPath01.visible = true
			
			if 1 <= $LeftPath01/Path2D/PathFollow2D.unit_offset:
				get_parent().LoopEnemyOver(EnemyId, $LeftPath01/Path2D/PathFollow2D.position)
				queue_free()
			else:
				$LeftPath01/Path2D/PathFollow2D.unit_offset += 0.5 * delta
				get_parent().UpdateEnemyPos(EnemyId, $LeftPath01/Path2D/PathFollow2D.position)
			
		LoopTypeId.Right01:
			#print("Loop Right 1Move")
			$LeftPath01.visible = true
			$RightPath01/Path2D/PathFollow2D.unit_offset += 0.5 * delta
