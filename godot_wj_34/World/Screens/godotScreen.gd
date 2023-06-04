extends Node2D


func _on_Timer_timeout():
	get_tree().change_scene("res://World/Screens/wildJam_splashscreen.tscn")
