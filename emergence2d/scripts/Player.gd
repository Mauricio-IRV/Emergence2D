extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

@export var projectile_scene: PackedScene 

var shoot_direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	
	# FIRST: Handle aiming input (Shift + WASD)
	if Input.is_action_pressed("shoot_ready_up") or Input.is_action_pressed("shoot_ready_down") or Input.is_action_pressed("shoot_ready_left") or Input.is_action_pressed("shoot_ready_right"):
		if Input.is_action_pressed("shoot_ready_up"):
			shoot_direction = Vector2.UP
		elif Input.is_action_pressed("shoot_ready_down"):
			shoot_direction = Vector2.DOWN
		elif Input.is_action_pressed("shoot_ready_left"):
			shoot_direction = Vector2.LEFT 
		elif Input.is_action_pressed("shoot_ready_right"):
			shoot_direction = Vector2.RIGHT
		
		# Handle shooting
		if Input.is_action_just_pressed("attack"):
			if shoot_direction == Vector2.RIGHT:
			#if shoot_direction != Vector2.ZERO:
				shoot()
				shoot_direction = Vector2.ZERO  # Reset after shooting

		# While aiming, stop player movement
		velocity.x = move_toward(velocity.x, 0, SPEED)

	else:
		# Normal Movement (no aiming mode)
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Handle crouch
		if Input.is_action_just_pressed("ui_down"):
			velocity.y = -(JUMP_VELOCITY/2)

		if directionX:
			velocity.x = directionX * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		# Animation Handling
		if directionX > 0:
			animatedSprite.animation = "run"
			animatedSprite.flip_h = false
		elif directionX < 0:
			animatedSprite.animation = "run"
			animatedSprite.flip_h = true
		elif directionY < 0:
			animatedSprite.animation = "jump"
		elif directionY > 0:
			animatedSprite.animation = "crouch"
		else:
			animatedSprite.animation = "idle"

	move_and_slide()

func shoot() -> void:
	animatedSprite.animation = "attack_horizontal"
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	projectile.setup(shoot_direction)
