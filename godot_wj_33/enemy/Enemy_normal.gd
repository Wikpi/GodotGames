extends KinematicBody2D

var dropped_currency = preload("res://world/assets/Currency/Gold_coin.tscn").instance()

export var ACCELERATION = 150
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4 

enum {
	IDLE,
	WANDER
}

var crr_animation;
var velocity = Vector2.ZERO
var state = IDLE
var run_state = false

onready var hurtBox = $HurtBox
onready var idleTimer = $IdleTimer

func _ready():
	get_node("..").connect("killed_enemy", self, "run_state")
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	match state:
		IDLE:
			if run_state == false:
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
				if $WanderControler.get_time_left() == 0:
					update_wander()
				if crr_animation == 1:
					$Animations.play("idleLeft")
					crr_animation = null
				elif crr_animation == 0:
					$Animations.play("idleRight")
					crr_animation = null
			else:
				update_wander()
				
		WANDER:
			if $WanderControler.get_time_left() == 0:
				update_wander()		
			accelerate_towards_point($WanderControler.target_position, delta)
			
			if global_position.distance_to($WanderControler.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
				
	velocity = move_and_slide(velocity)

func run_state():
	run_state = true

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	if run_state == false:
		if velocity.x < 0:
			$Animations.play("walk_left")
			crr_animation = 1
		else:
			$Animations.play("walk_right")
			crr_animation = 0
			
	elif run_state == true:
		if velocity.x < 0:
			$Animations.play("run_left")
		else:
			$Animations.play("run_right")

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	$WanderControler.start_wander_timer(rand_range(1, 3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_HurtBox_area_entered(area):
	$Stats.health -= area.damage
	$HurtBox._hitSound()
	if $Stats.health == 0:
		get_node("../../Currency").call_deferred("add_child", dropped_currency)
		dropped_currency.global_position = global_position
		queue_free()
