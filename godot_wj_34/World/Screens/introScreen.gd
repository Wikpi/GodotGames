extends Node2D

export (PackedScene) var target_scene

var messages = [
	"In a faraway corner of the galaxy, lies a kingdom... A kingdom of fierce and brave \n warriors, or as some may know them to be, CARROTS!", 
	"Tis a peacful race, one, who never breaks into pitiful wars and petty \n missunderstandings... and one, who values its own kin, race above all else.",
	"Word spread of this mysterious race and soon other races, tribes and whatnot \n would come and forecfully try to capture the carrots... ",
	"And now, at long last, one descendant, the mightiest of them all, sets out on an \n endless journey to finally rescue his race... "
]

var typing_speed = .065
var read_time = 1.8

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
	$Timer.start(1)
	$AnimationPlayer.play("New Anim")
	

func _on_next_char_timeout():
	if (current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		display += next_char
		
		$Label.text = display
		current_char += 1
	else:
		$next_char.stop()
		$next_message.one_shot = true
		$next_message.set_wait_time(read_time)
		$next_message.start()

func _on_next_message_timeout():
	if (current_message == len(messages) - 1):
		stop_dialogue()
	else: 
		current_message += 1
		display = ""
		current_char = 0
		$next_char.start()


func _on_Button_pressed():
	$Button.visible = false
	stop_dialogue()


func _on_Timer_timeout():
	var next = get_tree().change_scene_to(target_scene)
