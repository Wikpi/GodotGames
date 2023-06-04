extends Area2D

func _on_first_floor_body_entered(body):
	if body.name == "Player":
		get_node("..").go_up = true
		


func _on_first_floor_body_exited(body):
	if body.name == "Player":
		get_node("..").go_up = false
