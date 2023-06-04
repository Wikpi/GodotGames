extends KinematicBody2D

var SPEED;
var direction = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var player;
var notDead = true
onready var stats = $Stats

func _ready():
	$AnimatedSprite.play("idle")
	rng.randomize()
	if get_node(".").name == "romanSHIELDMAN":
		SPEED = rng.randf_range(90, 135)
	else:
		SPEED = rng.randf_range(170, 225)
	
func _physics_process(delta):	
	if PlayerStats.foundPlayer == false or notDead == false:
		direction = Vector2.ZERO
	elif PlayerStats.endOfFirstLEvel == true:
		player = Vector2(-100, 150)
		$AnimatedSprite.flip_h = true
		direction = (player - position).normalized()
	else:
		player = get_node("../../Player")
		direction = (player.position - position).normalized()
	
	if direction != Vector2.ZERO:
		$AnimatedSprite.play("walk_r")
	else:
		$AnimatedSprite.play("idle")
		
	move_and_slide(direction * SPEED)
	


func _on_HurtBox_area_entered(area):
	if area.get_parent().is_in_group("Bullets"):
		if area.name == "HitBox":
			stats.health -= area.damage
			$EXPLOSION.visible = true
			$EXPLOSION.play("default")
			if stats.health == 0:
				notDead = false
				$hitSound.play()
				yield($hitSound, "finished")
				$CollisionShape2D.set_deferred("disabled", true)
				queue_free()
