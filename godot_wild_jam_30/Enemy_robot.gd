extends Area2D

var velocity = Vector2.ZERO
onready var timer = $Timer
var direction = 0.5

func _physics_process(delta):	
	velocity = self.position
	velocity.y += direction
	self.position = velocity

func _on_Enemy_robot_body_entered(body):
	if direction == 0.5:
		direction = -0.5
	elif direction == -0.5:
		direction = 0.5
