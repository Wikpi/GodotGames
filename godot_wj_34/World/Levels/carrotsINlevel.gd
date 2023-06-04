extends Control

func _process(_delta):
	if get_node("../../YSort/Player") != null:
		$carrot_count.text = str(PlayerStats.carrot_count)
	else:
		return
