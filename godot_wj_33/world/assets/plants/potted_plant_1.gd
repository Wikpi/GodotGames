extends StaticBody2D

func _on_HurtBox_area_entered(area):
	$Stats.health -= area.damage
	$HurtBox._hitSound()
	if $Stats.health == 0:
		$Sprite.play("gone")
		get_node("CollisionShape2D").set_deferred("disabled", true)
