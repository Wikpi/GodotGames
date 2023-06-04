extends KinematicBody2D

var SPEED = 150

onready var player = get_node("../../Player")
onready var stats = $Stats

func _physics_process(_delta):
	if player:
		var direction = (player.position - position).normalized()
		if direction.x > 0:
			$AnimatedSprite.play("walk_r")
			get_node("HitBox/CollisionShape2D").position.x = 118.569
			get_node("HitBox/CollisionShape2D").position.y = -24.558
		else:
			$AnimatedSprite.play('walk_l')
			get_node("HitBox/CollisionShape2D").position.x = -31.362
			get_node("HitBox/CollisionShape2D").position.y = -19.518
		move_and_slide(direction * SPEED)


func _on_HurtBox_area_entered(area):
	if area.get_parent().get_name() != "Enemies":
		stats.health -= area.damage
		#$HurtBox._hitSound()
		if stats.health == 0:
			queue_free()
