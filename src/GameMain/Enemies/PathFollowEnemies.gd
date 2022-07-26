#PathFollowEnemies
extends Node2D

#enum LoopTypeId {Left01=0, Right01=1}

var LoopType = GlobalNode.LoopType.Left01
#var LoopType = LoopTypeId.Left01
var EnemyId
var LoopId


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$LeftPath01.visible = true
	#$RightPath01.visible = true
	pass
	

func SetLoopType(var looptype : int):
	LoopType = looptype
	match LoopType:
			
		GlobalNode.LoopType.Left01:
			pass
			#print("Loop Left 01Ready")
			#$LeftPath01.visible = true
			
		GlobalNode.LoopType.Right01:
			pass
			#print("Loop right01 Ready")
			#$RightPath01.visible = true

func SetEnemyId(var enid):
	EnemyId= enid

func SetLoopId(var lpid):
	LoopId = lpid
	
func _process(delta: float) -> void:
	match LoopType:
		GlobalNode.LoopType.Left01:
			#print("LoopType01Move")
			#$LeftPath01.visible = true
			
			if 1 <= $LeftPath01/Path2D/PathFollow2D.unit_offset:
				get_parent().LoopEnemyOver(EnemyId, $LeftPath01/Path2D/PathFollow2D.position)
				queue_free()
			else:
				$LeftPath01/Path2D/PathFollow2D.unit_offset += 0.5 * delta
				get_parent().UpdateEnemyPos(EnemyId, $LeftPath01/Path2D/PathFollow2D.position)
			
		GlobalNode.LoopType.Right01:
			print("Loop Right 1 Move ==============")
			#$RightPath01.visible = true
			#if 1 <= $RightPath01/RightPath2D/RightPathFollow2D.unit_offset:
			if 1 <= $RightPath01/Path2D/PathFollow2D.unit_offset:
				get_parent().LoopEnemyOver(EnemyId, $RightPath01/Path2D/PathFollow2D.position)
				queue_free()
			else:
				$RightPath01/Path2D/PathFollow2D.unit_offset += 0.5 * delta
				get_parent().UpdateEnemyPos(EnemyId, $RightPath01/Path2D/PathFollow2D.position)


			
#			$RightPath01/Path2D/PathFollow2D.unit_offset += 0.5 * delta
