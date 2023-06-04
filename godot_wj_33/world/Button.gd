extends Button

export var reference_path = ""
export(bool) var start_focused = false

func _ready():
	if(start_focused):
		grab_focus()
	connect("mouse_entered",self,"_on_Button_mouse_entered")
	connect("pressed",self,"_on_Button_Pressed")

func _on_Button_mouse_entered():
	grab_focus()

func _on_Button_Pressed():
	if get_parent().name == "Boss talk":
		get_tree().paused = false
		get_node("..").visible = false
		
	elif get_parent().name == "DeathScene" :
		print('here')
		PlayerStats.reset()
		get_tree().change_scene(reference_path)
		
	elif get_parent().name == "WinScreen" :
		print('hmm')
		PlayerStats.reset()
		get_tree().change_scene(reference_path)
		
	else:
		if(reference_path != ""):
			get_tree().change_scene(reference_path)
		else:
			get_tree().quit()
