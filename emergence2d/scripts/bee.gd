extends CharacterBody2D

@onready var player = $"../../Player"
@onready var bee = $AnimatedSprite2D

const SPEED = 100.0
const PATROL_RANGE = [-40, 40]

const Y_CHASE_RANGE = 20
const X_CHASE_RANGE = 100

const L_COLLISION_RANGE = 22
const R_COLLISION_RANGE = 22

const GRAVITY = 500.0
const MAX_FALL_SPEED = 300.0

var chase = false
var rebounding = false

var health = 1
var direction = 1
var init_pos = Vector2()

func _ready() -> void:
	init_pos = position

func add_movement() -> void:
	velocity.x = SPEED * direction
	var y_dist = abs(player.position.y - position.y)
	
	# Determine if player is in chase range
	var in_chase_range = (
		y_dist < Y_CHASE_RANGE and 
		position.distance_to(player.position) <= X_CHASE_RANGE
	)

	# Update chase flag
	if in_chase_range:
		chase = true
	elif not in_chase_range and not rebounding:
		# Only stop chasing if truly out of range and not rebounding
		chase = false

	# Handle collision with player
	if position.distance_to(player.position) <= L_COLLISION_RANGE and direction == -1 or position.distance_to(player.position) <= R_COLLISION_RANGE and direction == 1:		
		velocity = Vector2(-direction * 400, -100)
		print ("from the bee", player.health)
		rebounding = true
		player.take_damage(20)
		player.update_heart_display()

	# Handle chasing
	elif chase:
		var dist_apart = player.position.x - position.x
		direction = sign(dist_apart)
		bee.animation = "attack"

	# Handle patrol
	elif position.x < (init_pos.x + PATROL_RANGE[0]):
		direction = 1
		bee.animation = "default"
		bee.flip_h = true

	elif position.x > (init_pos.x + PATROL_RANGE[1]):
		direction = -1
		bee.animation = "default"
		bee.flip_h = false

func die() -> void:
	bee.animation = "hit"

func _physics_process(delta: float) -> void:
	# Apply gravity if rebounding
	if rebounding:
		velocity.x = move_toward(velocity.x, 0, 1000 * delta)
		velocity.y = clamp(velocity.y + GRAVITY * delta, -MAX_FALL_SPEED, MAX_FALL_SPEED)
		if abs(velocity.x) < 30:
			rebounding = false
	else:
		# Reset vertical motion unless rebounding
		velocity.y = 0
		add_movement()
	
	if player.health <= 0:
		player.die()
	else:
		move_and_slide()
