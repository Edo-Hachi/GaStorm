#Main_Node2D
extends Node2D

var GameMainScen = preload("res://src/GameMain/GameMain_Node2D.tscn")
#var gamemain

func _ready() -> void:
	randomize()

	$BackGroundStars.StarSpeed = 10
	
	GlobalNode.GameState = GlobalNode.GState.TITLE
	
	#gamemain = GameMainScen.instance()
	#add_child(gamemain)
	

func _process(delta: float) -> void:
	#update()	#_drawを再描画
	pass
	
#func _draw() -> void:
#	pass
	
#スタートボタン押下	
func _on_Button_button_down() -> void:

	GlobalNode.GameState = GlobalNode.GState.GAMEPLAY
	
	#get_tree().change_scene("res://src/GameMain/GameMain_Node2D.tscn")
	var gamescn = GameMainScen.instance()
	add_child(gamescn)
	gamescn.GameStartInit()
	
	#get_tree().get_node("MainScene").vislble = false
	$CanvasLayer/TitleNode.visible = false
#	$CanvasLayer/Button.visible = false
#	$CanvasLayer/Label.visible = false
	
	
#	var aa= get_node("/root/GameMain/GameMain_Node2D")
#	aa.GameStartInit()


#func catch_in_main(var data):
#	print("catch_in_main", data)
