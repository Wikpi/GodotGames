extends Area2D

onready var audio  = $AudioStreamPlayer

func _on_Gold_coin_body_entered(body):
	if body.name ==  "Player":
		audio.play()
		yield(audio, "finished")
		PlayerStats.currency_count += 1
		queue_free()


func _on_AudioStreamPlayer_finished():
	pass # Replace with function body.
