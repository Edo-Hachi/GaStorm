extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
class STAR:
	var Pos : Vector2
	var WH : Vector2
	var Speed = 0.0
	var StarColor : Color

var StarList = []

const STARMAX = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#debug
	randomize()
	
	var _star
	var _wh
	var _colr
	var _colg
	var _colb
	
	for i in range(0, STARMAX):
		_star = STAR.new()
		
		_star.Pos = Vector2(randi()%256+1, randi()%256+1)
		#_wh = randi()%2+1
		_wh = 1 # rand_range(1,1)
		_star.WH = Vector2(_wh, _wh)
		_star.Speed = randi()%8 + 0.2
		_colr = randi()%30 * _star.Speed + 0.2
		_colg = randi()%30 * _star.Speed + 0.2
		_colb = randi()%30 * _star.Speed + 0.2
		_star.StarColor = Color(_colr, _colg, _colb)
		
		StarList.append(_star)	
	pass # Replace with function body.

func _draw() -> void:
	var _rect
	
	for i in StarList.size():
		StarList[i].Pos.y += (StarList[i].Speed / 3)+0.5
		if 256 < StarList[i].Pos.y:
			StarList[i].Pos.x = randi() % 256 + 1
			StarList[i].Pos.y = -8
		
		_rect = Rect2(StarList[i].Pos, StarList[i].WH)
		draw_rect(_rect, StarList[i].StarColor, true)
#func _update():
#	pass:
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	update()
