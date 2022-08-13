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

export var StarSpeed = 5 #小さくすると速くなるよ
export var StarDirection = 1 #-1にすると逆スクロールだよ　

func SetStarSpeed(var spd, var direction):
	StarSpeed = spd
	StarDirection = direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#debug
	#randomize()
	
#	var _star
#	var _wh
#	var _colr
#	var _colg
#	var _colb
	
	for i in range(0, STARMAX):
		var star = STAR.new()
		
		star.Pos = Vector2(randi()%256+1, randi()%256+1)
		#_wh = randi()%2+1
		var _wh = 1 # rand_range(1,1)
		star.WH = Vector2(_wh, _wh)
		#_star.Speed = randi()%8 + 0.1
		star.Speed = rand_range(0, 10)

		var _colr = randi()%20 * star.Speed
		var _colg = randi()%20 * star.Speed
		var _colb = randi()%20 * star.Speed
		
		star.StarColor = Color8(_colr, _colg, _colb)
		
		StarList.append(star)	

func _draw() -> void:
	var _rect
	
	for i in StarList.size():
		
		StarList[i].Pos.y += (StarList[i].Speed / StarSpeed) * StarDirection
		
		if (256 + 32) < StarList[i].Pos.y:
			StarList[i].Pos.x = randi() % 256 + 1
			StarList[i].Pos.y = -32

		if StarList[i].Pos.y < -32:
			StarList[i].Pos.x = randi() % 256 + 1
			StarList[i].Pos.y = (256 + 32)
			
		_rect = Rect2(StarList[i].Pos, StarList[i].WH)
		draw_rect(_rect, StarList[i].StarColor, true)

func _process(delta: float) -> void:
	update()
