extends Area2D

var velocity = Vector2.ZERO
var look_vector = Vector2.ZERO
var player = null
var speed = 3
onready var audio = $AudioStreamPlayer

func _ready():
	
	look_vector = player.position - global_position
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	
	velocity = velocity.move_toward(look_vector, delta)
	velocity = velocity.normalized() * speed
	position += velocity


func _on_Bullet_body_entered(body):
	if body.get_parent().get_name() == "Enemies":
		pass
	else:
		audio.play()
		yield(audio, "finished")
		queue_free()


func _on_AudioStreamPlayer_finished():
	pass # Replace with function body.
