extends Label

func _process(delta):
	$currency_count.text = str(get_node("../../../YSort/Player").currency_count)
