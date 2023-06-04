extends Label

var ms = 0
var s = 0
var m = 0

func _process(delta):
	
	if ms > 9:
		PlayerStats.scroll_speed += 0.01
		s += 1
		ms = 0
		
	if s > 59:
		m += 1
		s = 0
	
	if m == 1:
		PlayerStats.numb_enemies += 1
		PlayerStats.numb_bales += 1
	
	if m == 5:
		PlayerStats.numb_enemies += 2
		PlayerStats.numb_bales += 2
		
	set_text(str(m) + ":" + str(s) + ":" + str(ms))


func _on_ms_timeout():
	ms += 1
