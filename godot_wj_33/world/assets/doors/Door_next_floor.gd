extends Area2D

onready var reminder = preload("res://player/Mission_reminder.tscn")
var reminder_message = null

export (PackedScene) var target_scene
var no_enemies = false
var on_door = false

func _input(event):
	if on_door == true:
		if get_parent().name == "BossFloor":
			$Label.text = "Jump?"
		
		if event.is_action_pressed("next_floor"):
			if get_overlapping_bodies().size() > 0:
				reminder_message = null
				if no_enemies == true:
					next_level()
				else:
					reminder_message = reminder.instance()
					get_node("..").call_deferred("add_child", reminder_message)
					reminder_message.global_position = get_node("../Player").global_position
					reminder_message.position.x -= 65
					reminder_message.position.y -= 130
					get_node("CollisionShape2D").disabled = true
					$Timer.start(4)
				
			
func next_level():
	var _ERR = get_tree().change_scene_to(target_scene)


func _on_Timer_timeout():
	reminder_message.queue_free()
	get_node("CollisionShape2D").disabled = false
	$Timer.stop()

func _on_Door_next_floor_body_entered(body):
	if body.name == "Player":
		on_door = true


func _on_Door_next_floor_body_exited(body):
	on_door = false
