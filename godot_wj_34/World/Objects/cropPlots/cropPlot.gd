extends Area2D

var on_cropPlot = false

func _input(event):
	if on_cropPlot == true:
		if event.is_action_pressed("pickUP"):
			pickCarrot()
			
func pickCarrot():
	PlayerStats.carrot_count += 5
	PlayerStats.all_carrot_count += 5
	$Sprite.play("empty")
	get_node("CollisionShape2D").set_deferred("disabled", true)
	

func _on_cropPlot_body_entered(body):
	if body.name == 'Player':
		on_cropPlot = true

func _on_cropPlot_body_exited(_body):
		on_cropPlot = false

