extends Node2D

var ColorA = 255
var TextColor :Color
var lblString

func SetStr(var lblstr):
	lblString = lblstr
	$lblMulti.text = lblString

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TextColor = Color8(0,170,240,ColorA)
	$lblMulti.add_color_override("font_color", TextColor)
	#self_modulate(text_color)

func _on_Timer_timeout() -> void:
#	$lblMulti.add_color_override("font_color", Color(5,170,240, ColorA))
	ColorA-=20
	TextColor = Color8(5,170,240,ColorA)
	$lblMulti.add_color_override("font_color", TextColor)
	position.y -= 1
	
	if ColorA < 0:
		queue_free()
