extends Area2D

var velocity = Vector2.ZERO
var look_vector = Vector2.ZERO
var mouseLocation = null
var speed = 15

func _ready():
	look_vector = (mouseLocation - global_position).normalized()
	rotation = get_angle_to(get_global_mouse_position())


func _physics_process(delta):
	velocity = Vector2.ZERO
	
	velocity = velocity.move_toward(look_vector, delta)
	velocity = velocity.normalized() * speed
	position += velocity


func _on_Bullet_body_entered(body):
	if body.name == "Player":
		pass
	else:
		$EXPLOSION.play()
		get_node(".").visible = false
		get_node("HitBox/CollisionShape2D").set_deferred("disabled", true)
		get_node("CollisionShape2D").set_deferred("disabled", true)

func _on_Bullet_area_entered(area):
	if area.get_parent().get_name() == "Enemies":
		$EXPLOSION.play()
		get_node(".").visible = false
		get_node("HitBox/CollisionShape2D").set_deferred("disabled", true)
		get_node("CollisionShape2D").set_deferred("disabled", true)
		
	else:
		pass

func _on_EXPLOSION_finished():
	queue_free()
