extends KinematicBody2D

var SPEED = 150
export var GRAVITY = 800
export var JUMP_POWER = 350
var velocity = Vector2.ZERO
var timer
var rndNumber1 = 60
var rndNumber2 = 100
var heartBeat = 60
var jump_count = 0

var stats = Stats

onready var speedRateLabel = get_node("../CanvasLayer/SpeedRate") 
onready var hurtBox = $HurtBox
onready var levelBack = $BackwardsLevelGoing
onready var level = get_node("../GameScreen/Level")

func _ready():
	stats.connect("no_health", self, "queue_free")
	timer = get_node("../CanvasLayer/Timer")
	timer.connect("timeout", self, "_on_Timer_timeout")

func _on_Timer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	heartBeat = rng.randf_range(rndNumber1, rndNumber2)

func _physics_process(delta):
	SPEED = stepify(heartBeat, 1)
	if velocity.x == 0:
		velocity.x = SPEED

	if is_on_wall():
		if $AnimatedSprite.flip_h == true:
			$AnimatedSprite.flip_h = false
			velocity.x = SPEED
		else:
			$AnimatedSprite.flip_h = true
			velocity.x = -SPEED

	$AnimatedSprite.play("Run")

	if Input.is_action_just_pressed("jump") && jump_count < 1:
		velocity.y -= JUMP_POWER
		jump_count += 1

	if is_on_ceiling():
		level.go_down = true
		levelBack.start(1)

	if is_on_floor():
		jump_count = 0
	else:
		if velocity.y < 0:
			$AnimatedSprite.play("Jump")
		else:
			$AnimatedSprite.play("Fall")
			
#	if Input.is_action_pressed("ui_left"):
#		velocity.x = -SPEED
#		$AnimatedSprite.flip_h = true
#	elif Input.is_action_pressed("ui_right"):
#		velocity.x = SPEED
#		$AnimatedSprite.flip_h = false

	speedRateLabel.text = str(stepify(heartBeat, 1))
	
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_HurtBox_area_entered(area):
	stats.health -= 1
	hurtBox.start_invincibility(1.5)
	hurtBox.create_hit_effect()
	var crr_hearts = stats.health
	if crr_hearts == 2:
		rndNumber1 = 110
		rndNumber2 = 150	
	elif crr_hearts == 1:
		rndNumber1 = 160
		rndNumber2 = 200
	elif crr_hearts == 0:
		get_tree().change_scene("res://DeathScene.tscn")


func _on_BackwardsLevelGoing_timeout():
	level.go_down = false
