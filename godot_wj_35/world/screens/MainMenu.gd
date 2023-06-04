extends Node2D

export (PackedScene) var target_scene

func _on_NewGame_pressed():
	$NewGame.visible = false
	$Controls.visible = false
	$Quit.visible = false
	
	$Timer.start(1)
	MusicController.fade_out()
	$AnimationPlayer.play("New Anim")

func _on_Controls_pressed():
	var optionS = get_tree().change_scene("res://world/screens/Options.tscn")

func _on_Timer_timeout():
	var next = get_tree().change_scene_to(target_scene)


func _on_Quit_pressed():
	get_tree().quit()



