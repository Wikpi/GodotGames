extends Node2D

func _ready():
	$edn.visible = false
	$Timer.one_shot
	$Timer.start(3)

func _on_Timer_timeout():
	$edn.visible = true
