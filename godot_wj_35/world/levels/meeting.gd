extends Node2D

export (PackedScene) var target_scene 

func _on_Timer_timeout():
	var next = get_tree().change_scene_to(target_scene)

func _on_DialogNode_dialogic_signal(value):
	if value == "true":
		$AnimatedSprite.visible = true
		$AnimatedSprite.play("default")
	else:
		$Timer.start(2)
		$AnimationPlayer.play("New Anim")
