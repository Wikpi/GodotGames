extends Node2D

onready var player = get_node("../../YSort/Player")
onready var controlScreen = preload("res://World/Screens/ControlScreen.tscn")

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if player.pauseON == 1:
			player.Pause.queue_free()
			player.pauseON -= 1
			get_tree().paused = false


func _on_Controls_pressed():
	var ControlScreen = controlScreen.instance()
	get_node("..").add_child(ControlScreen)


func _on_FullScreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
