extends Node2D

var rng = RandomNumberGenerator.new()
var roman1 = preload("res://enemies/romans/romanSoldier1.tscn")
var romanSHIELDMAN = preload("res://enemies/romans/romanSHIELDMAN.tscn")

var numb_roman1 =  PlayerStats.numb_roman1
var numb_romanSHIELDMAN = PlayerStats.numb_romanSHIELDMAN

var TweenNode;
var rrr = 1
var spawnSHIELD = false

onready var player = get_node("YSort/Player")
onready var movingCamera = get_node("movingCamera")
onready var playerCamera = get_node("Camera2D")
onready var levelCamera = get_node("levelCamera")

func _ready():
	MusicController.play_library()
	MusicController.fade_in_quick()
	get_node("YSort/leaveAREA/CollisionShape2D").disabled = true
	get_node("HealthUI").visible = false
	get_node("timerCounterr").visible = false
	TweenNode = get_node("movingCamera/Tween")
	rng.randomize()

func _process(_delta):
	if get_node("Dialogic").get_child_count() == 0 and levelCamera.current == true and rrr == 1:
		get_node("timerCounterr").visible = true
		get_node("timerCounterr/Countdown/countDownTimer").start(0.1)
		get_node("HealthUI").visible = true
		PlayerStats.foundPlayer = true
		player.shoot()
		$Timer.start()
		$chargeSFX.play()
		get_node("barrier/CollisionShape2D").set_deferred("disabled", true)
		rrr = 0
		
	if PlayerStats.endOfFirstLEvel == true:
		get_node("shootBox/CollisionShape2D").disabled = true

func add_objects():
	if PlayerStats.endOfFirstLEvel == true:
		remove_enemies()
	else:
		add_roman1()
		if spawnSHIELD == true:
			add_romanSHIELDMAN()
		$Timer.start(3)

func add_roman1():
	for i in range(numb_roman1):
		var Roman = roman1.instance()
		var rndX = rng.randi_range(-950, 0)
		var rndY = rng.randi_range(150, 756)
		Roman.position = Vector2(rndX, rndY)
		get_node("YSort/Enemies").add_child(Roman)
		
		
func add_romanSHIELDMAN():
	for i in range(numb_romanSHIELDMAN):
		var RomanSHIELD = romanSHIELDMAN.instance()
		var rndX = rng.randi_range(-1200, 0)
		var rndY = rng.randi_range(135, 756)
		RomanSHIELD.position = Vector2(rndX, rndY)
		get_node("YSort/Enemies").add_child(RomanSHIELD)
		

func remove_enemies():
	while get_node("YSort/Enemies").get_child_count() != 0:
		for n in get_node("YSort/Enemies").get_children():
			get_node("YSort/Enemies").remove_child(n)
		

func _on_Timer_timeout():
	add_objects()

func _on_shootBox_body_entered(body):
	if body.name == "Player":
		movingCamera.position = playerCamera.position
		TweenNode.interpolate_property(movingCamera, "position",
		playerCamera.position,
		levelCamera.position, 1.5, Tween.TRANS_LINEAR)
		movingCamera.current = true
		TweenNode.start()
		player.onShootBox = true 


func _on_shootBox_body_exited(body):
	if body.name == "Player":
		player.move()
		get_node("YSort/wall/left").set_deferred("disabled", false)
		TweenNode.interpolate_property(movingCamera, "position",
		levelCamera.position,
		playerCamera.position, 1.5, Tween.TRANS_LINEAR)
		movingCamera.current = true
		get_node("timerCounterr").visible = false
		get_node("HealthUI").visible = false
		TweenNode.start()
		player.onShootBox = false
		var dialogic = Dialogic.start("endOfFight")
		get_node("Dialogic").add_child(dialogic)
		get_node("YSort/leaveAREA/CollisionShape2D").set_deferred("disabled", false)


func _on_Tween_tween_completed(object, key):
	if player.onShootBox == false:
		playerCamera.current = true
	if player.onShootBox == true:
		var dialog = Dialogic.start("soldierTalk")
		get_node("Dialogic").add_child(dialog)
		levelCamera.current = true


func _on_leaveAREA_body_entered(body):
	if body.name == "Player":
		get_node("darkenNode/AnimationPlayer").play("New Anim")
		MusicController.fade_out()
		get_node("darkenNode/Timer2").start(3)
	

func _on_Timer2_timeout():
	var next = get_tree().change_scene("res://world/levels/secondFly.tscn")


func _on_civilianTalk_body_entered(body):
	if body.name == "Player":
		var dialog2 = Dialogic.start("civilianTalk")
		get_node("Dialogic").add_child(dialog2)
		get_node("YSort/civilians/civilianTalk/CollisionShape2D").set_deferred("disabled", true)
