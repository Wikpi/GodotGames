extends StaticBody2D

onready var reminder_message = get_node("Mission_reminder")

func _ready():
	reminder_message.messages = ["Hey! \n I smuggled in some goodies \n for you!"]
	reminder_message.visible = false

func _on_Timer_timeout():
	reminder_message.queue_free()
	$Timer.stop()


func _on_Area2D_body_entered(body):
	reminder_message.visible = true
	$Area2D.queue_free()
	$Timer.start(8)
