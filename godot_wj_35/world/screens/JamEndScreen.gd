extends Node2D

var first = "Art by - TimeSauce"
var second = "Music, sounds and voice acting by - \n SleepyUFO and Jen-ocide"
var third = "Programmed by - TimeSauce"
var rrr = 1

func _ready():
	MusicController.play_intro()
	MusicController.fade_in_quick()
	
	var dialog = Dialogic.start("thanksForPlaying")
	$Dialogic.add_child(dialog)

func _process(delta):
	if get_node("Dialogic").get_child_count() == 0 and rrr == 1:
		rrr = 0
		$Label.text = first
		$Timer.start(5)

func _on_Timer_timeout():
		if $Label.text == first:
			$Label.text = second
			$Timer.start(5)
		elif $Label.text == second:
			$Label.text = third
			$Timer.start(5)
		elif $Label.text == third:
			$Label.text = ""
