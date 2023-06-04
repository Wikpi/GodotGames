extends Label

func _process(delta):
	self.text = "Brothers yet to \n be saved: " + str(10000000 - PlayerStats.all_carrot_count)
