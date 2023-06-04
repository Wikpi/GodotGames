extends KinematicBody2D

var dropped_currency = preload("res://world/assets/Currency/Gold_coin.tscn").instance()
onready var bulletScene = preload("res://enemy/Bullet.tscn")
onready var player = get_node("../../Player")

var velocity = Vector2.ZERO
var SPEED = 200
var ACCELERATION = 500
var wait_time = rand_range(0.5, 1)

func _physics_process(delta):
	if player != null:
		if player.position.x - global_position.x < 0:
			$AnimatedSprite.play("shootLeft")
		else:
			$AnimatedSprite.play("shootRight")
		
		velocity = position.direction_to(player.position) * SPEED * delta
	else:
		velocity = Vector2.ZERO
	
	velocity = velocity.normalized()
	velocity = move_and_collide(velocity)

func _on_HurtBox_area_entered(area):
	if area.get_parent().get_name() == "Enemies":
		pass
	else:
		$HurtBox._hitSound()
		$Stats.health -= area.damage
		if $Stats.health == 0:
			get_node("../../Currency").call_deferred("add_child", dropped_currency)
			dropped_currency.global_position = global_position
			queue_free()

func fire():
	var bullet = bulletScene.instance()
	bullet.position = get_global_position()
	bullet.player = player
	get_parent().add_child(bullet)
	$gunshot.play()
	$Timer.set_wait_time(wait_time)


func _on_Timer_timeout():
	if player != null:
		fire()
