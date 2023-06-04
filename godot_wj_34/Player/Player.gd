extends KinematicBody2D

var SPEED = 350
var ACCELERATION = 800

var velocity = Vector2.ZERO
var mouseLocation;

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var bulletsLoad = preload("res://Player/laser_bullet.tscn")
onready var pause = preload("res://World/Screens/PauseScreen.tscn")

var pauseON = 0
var Pause

enum {
	MOVE,
	ATTACK
	MOVEonLEVEL
}
var state

func _ready():
	animationTree.active = true
	
	if get_owner().name == "Hub":
		state = MOVE
	
	else:
		state = MOVEonLEVEL

func _physics_process(_delta):
	match state:
		MOVE:
			move()

		ATTACK:
			attack()
			
		MOVEonLEVEL:
			moveLevel()

func move():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
	input_vector.y = Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")
	input_vector = input_vector.normalized( ) 
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/walk/blend_position", input_vector)
		animationTree.set("parameters/attack/blend_position", input_vector)
		animationState.travel("walk")
		velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION)
	
	velocity = move_and_slide(velocity)

func _input(event):
	if event is InputEventMouseButton:
		if state != ATTACK:
			if event.button_index == BUTTON_LEFT:
				if get_owner().name == "LevelEarth":
					mouseLocation = event.position
					state = ATTACK

func _process(delta):
	#print(crr)
	if Input.is_action_just_pressed("pause"):
		if pauseON == 0:
			pauseON += 1
			Pause = pause.instance()
			Pause.position.x = 653.262
			Pause.position.y = 480.57
			get_node("../../CanvasLayer").call_deferred("add_child", Pause)
			get_tree().paused = true
			

func attack():
	animationState.travel("attack")
	
func attack_finished():

	var bullet = bulletsLoad.instance()
	bullet.position = get_global_position()
	bullet.mouseLocation = mouseLocation
	get_parent().add_child(bullet)
	state = MOVEonLEVEL

	
func moveLevel():
	var input_vector = Vector2.ZERO
	input_vector.y = Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")
	input_vector = input_vector.normalized( ) 
	animationTree.set("parameters/run_r/blend_position", input_vector)
	animationState.travel("run_r")
	velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION)
	velocity = move_and_slide(velocity)
	
func _on_HurtBox_area_entered(area):
	PlayerStats.health -= area.damage
	$HurtBox.start_invincibility(1)
	$hitSound.play()
	$HurtBox.create_hit_effect()
	
	if PlayerStats.health <= 0:
		get_tree().change_scene("res://World/Levels/Hub.tscn")
		PlayerStats.reset()
		if PlayerStats.carrot_count >= 10:
			PlayerStats.carrot_count - 10
