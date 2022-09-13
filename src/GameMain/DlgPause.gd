extends Popup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shot"):
		get_tree().paused = false
		hide()	

func _on_Button_pressed() -> void:
#	print("Pressed")
	get_tree().paused = false
	hide()	
