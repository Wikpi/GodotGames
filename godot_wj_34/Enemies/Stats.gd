extends Node

export var max_health = 1 setget set_max_health
var health = max_health setget set_health

export (PackedScene) var targetScene

signal health_changed(value)
signal max_health_changed(value)

var carrot_count = 0
var all_carrot_count = 0
var damage = 1

var numb_plots = 5
var numb_bales = 5
var numb_enemies =  1
var scroll_speed = 0.4

var visible_r = true
var visible_arrow = true

var visible_e = true
var visible_arrow_e = true

func _ready():
	self.health = max_health

func _process(delta):
	if all_carrot_count >= 10000000:
		var _ERR = get_tree().change_scene_to(targetScene)

func reset():
	health = max_health
	carrot_count = 0
	numb_plots = 5
	numb_bales = 5
	numb_enemies =  1
	scroll_speed = 0.4

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
