extends Node

var bgMusic = load("res://sounds/BGMusic.wav")

func play_music():
	
	$BGMusic.stream = bgMusic
	$BGMusic.play()

func _on_BGMusic_finished():
	$BGMusic.stream = bgMusic
	$BGMusic.play()
