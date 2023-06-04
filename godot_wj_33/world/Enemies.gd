extends YSort

onready var enemy_count_in_room = get_child_count()

signal killed_enemy

func _process(_delta):
	if get_child_count() != enemy_count_in_room:
		emit_signal("killed_enemy")
	
	if get_child_count() == 0:
		if get_node("../Door_next_floor"):
			get_node("../Door_next_floor").no_enemies = true


	
