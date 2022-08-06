#Main_Node2D
extends Node2D

func _ready() -> void:
	$BackGroundStars.StarSpeed = 10
	
	#GlobalNode.GState = GlobalNode.GState.TITLE
	GlobalNode.GameState = GlobalNode.GState.TITLE

	randomize()

func _process(delta: float) -> void:
	update()	#_drawを再描画
	pass
	
func _draw() -> void:
	var pos = Vector2(128,128)
	var arc = 60
	var angle_s = 0
	var angle_e = 90
	#draw_circle(pos, 30, Color(128,128,128))
	#draw_arc(pos, 60, 0, 90, Color(128,128,128))
	draw_arc(pos, 60, angle_s, angle_e, 64, Color(128,0,0), 6,false)
	
	
	#draw_circle_arc(pos, radi, angle_f, angle_e, Color.purple)
	
	
func _on_Button_button_down() -> void:

	GlobalNode.GameState = GlobalNode.GState.GAMEPLAY
	
	get_tree().change_scene("res://src/GameMain/GameMain_Node2D.tscn")

func catch_in_main(var data):
	print("catch_in_main", data)
