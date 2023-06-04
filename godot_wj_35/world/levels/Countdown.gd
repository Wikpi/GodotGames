extends Control

var minutes = 2
var seconds = 1
var dsec = 10

func _physics_process(delta):
	if seconds > 0 and dsec <= 0:
		seconds -= 1
		dsec = 10
	if minutes > 0 and seconds <= 0:
		minutes -= 1
		seconds = 60
	
	if seconds == 0 and minutes == 0 and dsec == 0:
		PlayerStats.endOfFirstLEvel = true
		self.queue_free()
	
	if seconds == 59 and minutes == 0:
		get_node("../..").spawnSHIELD = true
		PlayerStats.numb_roman1 = 3
	
	if seconds >= 10:
		$sec.set_text(str(seconds))
	else:
		$sec.set_text("0" +str(seconds))
	if dsec >= 10:
		$dsec.set_text(str(dsec))
	else:
		$dsec.set_text("0" +str(dsec))
	if minutes >= 10:
		$min.set_text(str(minutes))
	else:
		$min.set_text("0" +str(minutes))

func _on_countDownTimer_timeout():
	dsec -= 1
