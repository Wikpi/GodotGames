extends Node2D

export (PackedScene) var target_scene
onready var controlScreen = preload("res://World/Screens/ControlScreen.tscn")

func _on_Controls_pressed():
	var ControlScreen = controlScreen.instance()
	get_node("..").add_child(ControlScreen)


func _on_FullScreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_NewGame_pressed():
	$NewGame.visible = false
	$Controls.visible = false
	$Quit.visible = false
	$FullScreen.visible = false
	
	$Timer.start(1)
	$AnimationPlayer.play("New Anim")


func _on_Timer_timeout():
	var next = get_tree().change_scene_to(target_scene)
