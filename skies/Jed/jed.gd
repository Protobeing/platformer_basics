extends CharacterBody2D

@onready var movement_anims = $movement
@onready var standing_anims = $standing_still
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	movement() # calling the movement function here
	# this is the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# this is the jumping script
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide() #without this line - nothing in the ohysics process will work right in game
	
func movement(): # this function handles animations tied to movement. you have to call it in the physics process though!
	if Input.is_action_pressed("ui_left"):
		movement_anims.play("run_left")
	if Input.is_action_pressed('ui_right'):
		movement_anims.play("run_right")
	
