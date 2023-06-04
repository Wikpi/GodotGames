extends AnimatedSprite

onready var beat = get_node("../MonitorBeat")

func _process(delta):
	if frame == 6:
		beat.play()
