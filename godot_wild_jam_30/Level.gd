extends Node2D

var velocity = Vector2.ZERO

var go_up = false
var go_down = false
var up = 0.05

func _process(delta):
	if velocity.y < 0:
		go_down = false
	
	elif velocity.y >= 976.4:
		up = 0
	else:
		up = 0.05
	
	velocity.y += up
	self.position = velocity
	if go_up == true:
		velocity.y += 0.6
		
	if go_down == true:
		velocity.y -= 0.1
	
