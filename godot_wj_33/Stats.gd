extends Node

export var max_health = 1 setget set_max_health
var health = max_health setget set_health

signal health_changed(value)
signal max_health_changed(value)

var currency_count = 0
var speed = 200
var damage = 1

func reset():
	health = 10
	speed = 200
	damage = 1
	currency_count = 0

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)

func _ready():
	if get_parent().name == "Player":
		damage = damage
	else:
		damage = 1
	self.health = max_health
