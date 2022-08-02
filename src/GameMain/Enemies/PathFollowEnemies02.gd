#Path Follow 2d Enemy02
extends Node

var LoopType = GlobalNode.LoopType.Left01
var EnemyId
var LoopId


func SetLoopType(var looptype):
	LoopType = looptype
	
func SetEnemyId(var enid):
	EnemyId= enid

func SetLoopId(var lpid):
	LoopId = lpid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	match LoopType:
		GlobalNode.LoopType.Left01:
			print("Left Loop")
			$LeftPath01/Path2D/PathFollow2D.unit_offset += 0.5 * delta
			get_parent().UpdateEnemyPos(EnemyId, $LeftPath01/Path2D/PathFollow2D.position)
			
			if 1<= $LeftPath01/Path2D/PathFollow2D.unit_offset:
				get_parent().LoopEnemyOver(EnemyId, $LeftPath01/Path2D/PathFollow2D.position)
				queue_free()
				
		GlobalNode.LoopType.Right01:
			print("Right Loop")
			$RightPath01/Path2D/PathFollow2D.unit_offset += 0.5 * delta
			get_parent().UpdateEnemyPos(EnemyId, $RightPath01/Path2D/PathFollow2D.position)
			
			if 1<= $LeftPath01/Path2D/PathFollow2D.unit_offset:
				get_parent().LoopEnemyOver(EnemyId, $RightPath01/Path2D/PathFollow2D.position)
				queue_free()
			
			
#			if 1 <= $LeftPath01/L01_Path2D/L01_PathFollow2D.unit_offset:
#				get_parent().LoopEnemyOver(EnemyId, $LeftPath01/L01_Path2D/L01_PathFollow2D.position)
#				queue_free()
#			else:
#				$LeftPath01/L01_Path2D/L01_PathFollow2D.unit_offset += 0.5 * delta
#
#				get_parent().UpdateEnemyPos(EnemyId, $LeftPath01/L01_Path2D/L01_PathFollow2D.position)
			
#		GlobalNode.LoopType.Right01:
#			#print("Loop Right 1 Move ==============")
#			if 1 <= $RightPath01/R01_Path2D/R01_PathFollow2D.unit_offset:
#				get_parent().LoopEnemyOver(EnemyId, $RightPath01/R01_Path2D/R01_PathFollow2D.position)
#				queue_free()
#			else:
#				$RightPath01/R01_Path2D/R01_PathFollow2D.unit_offset += 0.5 * delta
#				get_parent().UpdateEnemyPos(EnemyId, $RightPath01/R01_Path2D/R01_PathFollow2D.position)

#	match LoopType:
#		LOOP01:
#			$PathCtrl01/Path2D/PathFollow2D.unit_offset += 0.1 * delta
#			EnemyObj.position = $PathCtrl01/Path2D/PathFollow2D.position
#
#			if 1 <= $PathCtrl01/Path2D/PathFollow2D.unit_offset:
#				queue_free()
#
#		LOOP02:
#			$PathCtrl02/Path2D/PathFollow2D.unit_offset += 0.1 * delta
#			EnemyObj.position = $PathCtrl02/Path2D/PathFollow2D.position
#			if 1 <= $PathCtrl02/Path2D/PathFollow2D.unit_offset:
#				queue_free()
