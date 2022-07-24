#Main_Node2D
extends Node2D

func _ready() -> void:
	randomize()

func _on_Button_button_down() -> void:
	get_tree().change_scene("res://src/GameMain/GameMain_Node2D.tscn")
	
