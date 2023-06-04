extends Node

var backgroundMusic = load("res://Action RPG Resources/Music and Sounds/[ONTIVA.COM]-Ultima V Soundtrack_ Song #01 Ultima Theme-128K.mp3")
var mute = false

func play_music():
	if mute:
		return
		
	if $Music.stream == backgroundMusic and $Music.playing:
		return
	
	$Music.stream = backgroundMusic
	$Music.play()
