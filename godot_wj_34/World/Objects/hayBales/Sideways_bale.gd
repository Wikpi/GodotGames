extends StaticBody2D

signal AnotherBodyON

func _on_HurtBox_area_entered(area):
	#print(area.get_parent().get_name())
	if area.get_parent().get_name() != "Enemies":
		$Stats.health -= area.damage
	#	if $Stats.health == 2:
	#		$Sprite.play("break1")
	#	elif $Stats.health == 1:
	#		$Sprite.play("break2")
		if $Stats.health == 0:
			$Sprite.play("gone")
			$Sprite.scale.x = 3
			$Sprite.scale.y = 3
			#$Sprite.offset.y = 20
			$Sprite.position.y = 80
			get_node("CollisionShape2D").set_deferred("disabled", true)
		
