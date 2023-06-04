extends KinematicBody2D

var SPEED = 300
var ACCELERATION = 700

var mouseLocation;
var onShootBox = false
var velocity = Vector2.ZERO
var shootCoolDown = false

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var bulletsLoad = preload("res://player/Bullet.tscn")
onready var smoke = preload("res://world/objects/smoke.png")
var talkCheese = 0

enum {
	MOVE
	SHOOT
	SHOOTCAR
}
var state

func _ready():
	talkCheese = 0
	animationTree.active = true
	
	state = MOVE

func _physics_process(_delta):
	match state:
		MOVE:
			move()
		SHOOT:
			shoot()
		SHOOTCAR:
			shootcar()

			
func move():
	state = MOVE
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
	input_vector.y = Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")
	input_vector = input_vector.normalized( ) 
	
	if input_vector != Vector2.ZERO:
		if talkCheese == 0:
			if get_parent().get_parent().get_name() == "alexandriaLevel":
				var dialog1 = Dialogic.start("cheeseFact")
				add_child(dialog1)
				talkCheese = 1
			else:
				var dialog1 = Dialogic.start("getInCar")
				add_child(dialog1)
				talkCheese = 1

		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Move/blend_position", input_vector)
		animationTree.set("parameters/Shoot/blend_position", input_vector)
		animationState.travel("Move")
		velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION)
	
	velocity = move_and_slide(velocity)

func _process(delta):	
	if Input.is_action_just_pressed("shoot"):
		if onShootBox == true and get_node("../../Dialogic").get_child_count() == 0 and shootCoolDown == false:
			state = SHOOT
			shootCoolDown = true
			mouseLocation = get_viewport().get_mouse_position()
			$Timer.start()
			var bullet = bulletsLoad.instance()
			bullet.position.x = self.position.x - 106
			bullet.position.y = self.position.y - 40
			bullet.mouseLocation = mouseLocation
			$rocketGun.play()
			get_parent().add_child(bullet)
					

func shoot():
	state = SHOOT
	animationState.travel("Shoot")
		


func shoot_finished():
	pass


func shootcar():
	pass

	
func _on_HurtBox_area_entered(area):
	if area.get_parent().is_in_group("Bullets"):
		pass
	else:
		if area.name == "HitBox":
			PlayerStats.health -= area.damage
			get_node("HurtBox").start_invincibility(0.6)
			$hitSound.play()
			if PlayerStats.health <= 0:
				MusicController.stop_music()
				var next = get_tree().change_scene("res://world/screens/youFailed.tscn")
				PlayerStats.reset()





func _on_Timer_timeout():
	shootCoolDown = false
