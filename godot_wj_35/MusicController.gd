extends Node

var Title_music = load("res://sounds/Through Time and Space - Title Screen BGM.mp3")
var intro_music = load("res://sounds/Through Time and Space - Intro BGM.mp3")
var library_music = load("res://sounds/Library_BGM.mp3")
var car_music = load("res://sounds/GameJamTrack_1.mp3")

func play_music():
	$Music.stream = Title_music
	$Music.play()
	
func play_intro():
	$Music.stream = intro_music
	$Music.play()

func play_library():
	$Music.stream = library_music
	$Music.play()

func play_car_music():
	$Music.stream = car_music
	$Music.play()

func stop_music():
	$Music.stop()


func fade_in():
	$fade_in.play("New Anim")
	
func fade_out():
	$fade_out.play("New Anim")
	yield($fade_out, "animation_finished")
	stop_music()
	
func fade_in_quick():
	$fade_in_quick.play("New Anim")
