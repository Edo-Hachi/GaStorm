extends CanvasLayer

var Parsec : int = 1
var ViewTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func DrawParsec(psc):
	Parsec = psc
	ViewTimer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var col = OS.get_ticks_usec()
	if col % 5 == 0:
		col = OS.get_ticks_usec() % GlobalNode.Colormax
		$lblReady.add_color_override("font_color", ColorN(GlobalNode.ColorName[col]))
		$lblParsec.text = "Parsec / %02d" % Parsec

		#自機を画面外からホームポジションへ
		#BGのスクロール速度も弄れたらいじる
			
	ViewTimer+=1
	if 60 * 2 < ViewTimer:	#2秒で消す
		visible = false
