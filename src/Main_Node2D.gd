#Main_Node2D
extends Node2D

func _ready() -> void:
	#GlobalNode.GState = GlobalNode.GState.TITLE
	GlobalNode.GameState = GlobalNode.GState.TITLE

	randomize()

func _process(delta: float) -> void:
	pass
	
	
func _on_Button_button_down() -> void:

	GlobalNode.GameState = GlobalNode.GState.GAMEPLAY
	
	get_tree().change_scene("res://src/GameMain/GameMain_Node2D.tscn")

func catch_in_main(var data):
	print("catch_in_main", data)
