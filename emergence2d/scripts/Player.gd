extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle Crouch
	if Input.is_action_just_pressed("ui_down"):
		velocity.y = -(JUMP_VELOCITY/2)

	# Get the input direction and handle the movement/deceleration
	# As good practice, you should replace UI actions with custom gameplay actions
	var directionX := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up", "ui_down")
	
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle right movement
	if directionX > 0:
		animatedSprite.animation = "run"
		animatedSprite.flip_h = false
	# Handle left movement
	elif directionX < 0:
		animatedSprite.animation = "run"
		animatedSprite.flip_h = true
	# Handle Jump
	elif directionY < 0:
		animatedSprite.animation = "jump"
	# Handle crouch
	elif directionY > 0:
		animatedSprite.animation = "crouch"
	else:
		animatedSprite.animation = "idle"
		
		

	move_and_slide()
