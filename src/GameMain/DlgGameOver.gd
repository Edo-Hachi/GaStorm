extends Popup




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

#func _on_Button_pressed() -> void:
#	print("Pressed")
#	get_tree().paused = false
#	hide()	


func _on_BtnGameOver_pressed() -> void:
	get_tree().paused = false
	hide()	
	pass # Replace with function body.
