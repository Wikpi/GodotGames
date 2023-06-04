extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var heartUIFull = $HeartFull
onready var heartUIEmpty = $HeartEmpty

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15
	
func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = max_hearts * 15
	
func _ready():
	self.max_hearts = Stats.max_health
	self.hearts = Stats.health
# warning-ignore:return_value_discarded
	Stats.connect("health_changed", self, "set_hearts")
# warning-ignore:return_value_discarded
	Stats.connect("max_health_changed", self, "set_max_hearts")
