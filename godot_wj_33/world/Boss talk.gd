extends Node2D

var messages = [
	"So they tricked another new agent, huh? They probably haven't told you who they truly \nare or anything concerning our real purpose. This device is supposed to save the world \nfrom your evil organisation... but now, that you've slaugthered all of my \npeople, you'll have to die along with your organisation... Prepare yourself!", 
]

var typing_speed = .1
var read_time = 2

var current_message = 0
var display = ""
var current_char = 0

func _ready():
	start_dialogue()
	
func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	
	$next_char.set_wait_time(typing_speed)
	$next_char.start()

func stop_dialogue():
	queue_free()

func _on_next_char_timeout():
	if (current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		display += next_char
		
		$Label.text = display
		current_char += 1
	else:
		pass
