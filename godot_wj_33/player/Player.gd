extends KinematicBody2D

var SPEED = PlayerStats.speed
var ACCELERATION = 500
 
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var hurtBox = $HurtBox

var velocity = Vector2.ZERO
enum {
	MOVE,
	ATTACK
}
var state = MOVE

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move(delta)

		ATTACK:
			attack()

func move(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
	input_vector.y = Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")
	input_vector = input_vector.normalized( ) 
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION)

	velocity = move_and_slide(velocity)
	
func attack():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func attack_finished():
	state = MOVE

func _on_HurtBox_area_entered(area):
	PlayerStats.health -= area.damage
	hurtBox.start_invincibility(1)
	if PlayerStats.health <= 0:
		get_tree().change_scene("res://world/DeathScene.tscn")
#	hurtBox.create_hit_effect()
#	var playerHurtSound = PlayerHurtSound.instance()
#	get_tree().current_scene.add_child(playerHurtSound)
