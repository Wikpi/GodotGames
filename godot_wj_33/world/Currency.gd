extends Control

func _process(_delta):
	if get_node("../../YSort/Player") != null:
		$currency_count.text = str(PlayerStats.currency_count)
	else:
		return
