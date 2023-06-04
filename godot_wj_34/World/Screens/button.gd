extends Button

export var reference_path = ""

func _ready():
	connect("pressed",self,"_on_Button_Pressed")

func _on_Button_Pressed():
	if(reference_path != ""):
		get_tree().paused = false
		get_tree().change_scene(reference_path)
	else:
		get_tree().quit()
