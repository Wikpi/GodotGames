extends TextureRect

var scroll_speed = PlayerStats.scroll_speed

func _process(delta):
	self.material.set_shader_param("scroll_speed", scroll_speed)
