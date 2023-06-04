extends StaticBody2D

export (PackedScene) var target_scene 
var on_door = false
func _ready():
	$r.visible = PlayerStats.visible_r
	$arrow.visible = PlayerStats.visible_arrow

func _input(event):
	if on_door == true:
		if event.is_action_pressed("exit"):
			PlayerStats.visible_r = false
			PlayerStats.visible_arrow = false
			#get_node("../Ysort/AnimationPlayer").play()
			next()

func next():
	var next = get_tree().change_scene_to(target_scene)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		on_door = true


func _on_Area2D_body_exited(body):
	on_door = false
