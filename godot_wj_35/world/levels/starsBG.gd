extends TextureRect

export (float) var scroll_speed

func _process(delta):
	self.material.set_shader_param("scroll_speed", scroll_speed)
