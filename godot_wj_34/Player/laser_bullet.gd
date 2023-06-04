extends Area2D

var velocity = Vector2.ZERO
var look_vector = Vector2.ZERO
var mouseLocation = null
var speed = 10

func _ready():
	look_vector = (mouseLocation - global_position).normalized()
	rotation = look_vector.angle()
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	
	velocity = velocity.move_toward(look_vector, delta)
	velocity = velocity.normalized() * speed
	position += velocity
	$Timer.start(1)

func _on_laser_bullet_body_entered(body):
	if body.name == "Player":
		pass
	else:
		queue_free()

func _on_HitBox_body_entered(body):
	if body.name == "Player":
		pass
	else:
		queue_free()


func _on_Timer_timeout():
	queue_free()
