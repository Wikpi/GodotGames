extends Label

func _process(delta):
	self.text = "Brothers already \n saved: " + str(PlayerStats.all_carrot_count)
