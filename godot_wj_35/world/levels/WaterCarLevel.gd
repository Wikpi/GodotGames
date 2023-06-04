extends Node2D

func _ready():
	MusicController.play_car_music()
	MusicController.fade_in_quick()

func _on_getInCar_body_entered(body):
	if body.name == "Player":
		MusicController.fade_out()
		$getInCar.play()
		get_node("darkenNode/AnimationPlayer").play("New Anim")

func _on_Timer_timeout():
	$carRevUp.play()

func _on_carRevUp_finished():
	var next = get_tree().change_scene("res://world/screens/JamEndScreen.tscn")

func _on_getInCar_finished():
	$Timer.start()
