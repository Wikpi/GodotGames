extends Node2D

func _on_Back_pressed():
	get_node(".").queue_free()
