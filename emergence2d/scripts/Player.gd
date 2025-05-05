extends CharacterBody2D

@onready var animatedSprite := $AnimatedSprite2D
@export var projectile_scene: PackedScene 
var shoot_direction: Vector2 = Vector2.ZERO
var direct_shoot_dir = Vector2.RIGHT

# seconds of forgiveness after falling
@export var coyote_time := 0.15
var coyote_timer := 0.0

@export var health := 100
const SPEED := 300.0
const JUMP_VELOCITY := -300.0

func _physics_process(delta: float) -> void:
	var directionX := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up", "ui_down")
	
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
				animatedSprite.flip_h  = false
				shoot("attack_horizontal")
				shoot_direction = Vector2.ZERO 
			elif shoot_direction == Vector2.UP:
				animatedSprite.flip_h = false
				shoot("attack_up")
				shoot_direction = Vector2.ZERO
			elif shoot_direction == Vector2.LEFT:
				animatedSprite.flip_h = true
				shoot("attack_horizontal")
				shoot_direction = Vector2.ZERO
				

		# While aiming, stop player movement
		velocity.x = move_toward(velocity.x, 0, SPEED)
	elif Input.is_action_just_pressed("attack"):
		if shoot_direction == Vector2.RIGHT or shoot_direction == Vector2.LEFT:
			shoot("attack_horizontal")
		elif shoot_direction == Vector2.UP:
			shoot("attack_up")
	else:
		# Coyote time logic
		if is_on_floor():
			coyote_timer = coyote_time
		else:
			coyote_timer = max(coyote_timer - delta, 0)

		# Add gravity
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump
		if Input.is_action_just_pressed("ui_up") and (is_on_floor() or coyote_timer > 0):
			velocity.y = JUMP_VELOCITY
			coyote_timer = 0 # prevent double jumping during coyote
			shoot_direction = Vector2.UP

		# Handle Crouch
		if Input.is_action_just_pressed("ui_down"):
			velocity.y = -(JUMP_VELOCITY/2)
			shoot_direction = Vector2.DOWN

		# Handle jump
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			shoot_direction = Vector2.UP

		# Handle crouch
		if Input.is_action_just_pressed("ui_down"):
			velocity.y = -(JUMP_VELOCITY/2)
			shoot_direction = Vector2.DOWN

		if directionX:
			velocity.x = directionX * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# Animation Handling
		if velocity.y > 350:
			fall_animation()
		else:
			if directionX > 0:
				animatedSprite.animation = "run"
				animatedSprite.flip_h = false
				shoot_direction = Vector2.RIGHT
				if Input.is_action_just_pressed("attack"):
					shoot("attack_horizontal")
			elif directionX < 0:
				animatedSprite.animation = "run"
				animatedSprite.flip_h = true
				shoot_direction = Vector2.LEFT
				if Input.is_action_just_pressed("attack"):
					shoot("attack_horizontal")
			elif directionY < 0:
				animatedSprite.animation = "jump"
				if Input.is_action_just_pressed("attack"):
					shoot_direction = Vector2.UP
					shoot("attack_up")
			elif directionY > 0:
				animatedSprite.animation = "crouch"
				if Input.is_action_just_pressed("attack"):
					shoot_direction = Vector2.DOWN
					shoot("attack_down")
			else:
				animatedSprite.animation = "idle"

	move_and_slide()

func shoot(dir) -> void:
	animatedSprite.animation = dir
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	projectile.setup(shoot_direction)

func fall_animation():
	animatedSprite.animation = "crouch"

func die():
	reset_scene()

func reset_scene():
	get_tree().reload_current_scene()
