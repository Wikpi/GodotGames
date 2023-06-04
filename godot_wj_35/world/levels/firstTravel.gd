extends Node2D

var goFaster = false

var type = true

export (PackedScene) var target_scene 

func _ready():
	MusicController.play_intro()
	MusicController.fade_in_quick()

func start_anim():
	MusicController.fade_out()
	$AnimationPlayer.play("New Anim")

func _process(_delta):
	if goFaster == true:
		$ship.position.x += 8.5
		$ship.play("goFaster")
	else:
		$ship.play("default")

func go_faster():
	goFaster = true

func change_Scene():
	var next = get_tree().change_scene_to(target_scene)


func _on_DialogNode_dialogic_signal(value):
	if value == "true":
		start_anim()
