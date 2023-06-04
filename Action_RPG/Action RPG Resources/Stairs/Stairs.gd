extends Area2D


func _on_Stairs_body_entered(body):
	if body.name == "Player":
		get_node("../YSort/Player").on_stairs = true


func _on_Stairs_body_exited(body):
	if body.name == "Player":
		get_node("../YSort/Player").on_stairs = false
