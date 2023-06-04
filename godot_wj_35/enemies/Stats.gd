extends Node

export var max_health = 1 setget set_max_health
var health = max_health setget set_health

signal health_changed(value)
signal max_health_changed(value)

var numb_roman1 = 4
var numb_romanSHIELDMAN = 1
var damage = 1
var foundPlayer = false
var endOfFirstLEvel = false
var stateShoot = false

func _ready():
	self.health = max_health

func reset():
	endOfFirstLEvel = false
	health = max_health
	foundPlayer = false
	var stateShoot = false
	var numb_roman1 = 3
	var numb_romanSHIELDMAN = 2

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
