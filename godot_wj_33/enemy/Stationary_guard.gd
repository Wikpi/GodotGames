extends KinematicBody2D

onready var bulletsLoad = preload("res://enemy/Bullet.tscn")

var dropped_currency = preload("res://world/assets/Currency/Gold_coin.tscn").instance()
onready var player = get_node("../../Player")
var shooting_state = false
var wait_time = rand_range(1.5, 2)

func _ready():
	get_node("..").connect("killed_enemy", self, "shoot_state")

func _on_HurtBox_area_entered(area):
	$Stats.health -= area.damage
	shooting_state = true
	$HurtBox._hitSound()
	if $Stats.health == 0:
		get_node("../../Currency").call_deferred("add_child", dropped_currency)
		dropped_currency.global_position = global_position
		queue_free()

func shoot_state():
	shooting_state = true

func fire():
	if player.position.x - global_position.x < 0:
		$AnimatedSprite.play("shootLeft")
	else:
		$AnimatedSprite.play("shootRight")
	$gunShot.play()
	var bullet = bulletsLoad.instance()
	bullet.position = get_global_position()
	bullet.player = player
	get_parent().add_child(bullet)
	$Timer.set_wait_time(wait_time)

func _on_Timer_timeout():
	if player != null:
		if shooting_state == true:
			fire()
