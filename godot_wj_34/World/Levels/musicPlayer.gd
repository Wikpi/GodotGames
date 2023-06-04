extends Node

var bgMusic = load("res://Sounds/mainTheme.wav")

func play_music():
	
	$BGMusic.stream = bgMusic
	$BGMusic.play()

func _on_BGMusic_finished():
	$BGMusic.stream = bgMusic
	$BGMusic.play()
