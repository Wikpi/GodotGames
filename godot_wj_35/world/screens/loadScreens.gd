extends Node2D

export (PackedScene) var changeScene 

func _ready():
	if get_node(".").name == "godotScreen":
		MusicController.fade_in()
		MusicController.play_music()
		

func _on_Timer_timeout():
	var next = get_tree().change_scene_to(changeScene)
