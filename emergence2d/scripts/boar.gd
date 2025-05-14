extends CharacterBody2D

@onready var player = $"../../Player"
@onready var boar = $AnimatedSprite2D
@onready var floorRaycast = $FloorRaycast

const SPEED = 40.0
const PATROL_RANGE = [-80, 80]

const Y_CHASE_RANGE = 20
const X_CHASE_RANGE = 250

const L_COLLISION_RANGE = 28
const R_COLLISION_RANGE = 33

var chase = false
var rebounding = false
var health = 1
var direction = 1
var init_pos = Vector2()

func _ready() -> void:
	init_pos = position

func add_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func add_movement() -> void:
	velocity.x = SPEED * direction
	var y_dist = abs(player.position.y - position.y)
	
	var in_chase_range = (
		y_dist < Y_CHASE_RANGE and 
		position.distance_to(player.position) < X_CHASE_RANGE
	)

	# Stop chasing if player is vertically too far or no ground below
	if not in_chase_range or not floorRaycast.is_colliding():
		chase = false
		boar.animation = "walk"

	# Handle Player Collision (Rebound & Damage)
	if position.distance_to(player.position) <= L_COLLISION_RANGE and direction == -1 or position.distance_to(player.position) <= R_COLLISION_RANGE and direction == 1:
		velocity = Vector2(-direction * 400, -100)
		rebounding = true
		player.take_damage(10)
		player.update_heart_display()

	# Handle Chase
	elif chase or in_chase_range:
		chase = true
		var dist_apart = player.position.x - position.x
		direction = sign(dist_apart)
		velocity.x = 4 * SPEED * direction
		boar.animation = "chase"
		boar.flip_h = direction == 1

	# Handle Patrol
	elif position.x < (init_pos.x + PATROL_RANGE[0]):
		direction = 1
		boar.animation = "walk"
		boar.flip_h = true
		
	elif position.x > (init_pos.x + PATROL_RANGE[1]):
		direction = -1
		boar.animation = "walk"
		boar.flip_h = false

func die() -> void:
	boar.animation = "die"

func _physics_process(delta: float) -> void:
	add_gravity(delta)
	
	# If rebounding, force in opposite direction
	if rebounding:
		velocity.x = move_toward(velocity.x, 0, 1000 * delta)
		if abs(velocity.x) < 30: rebounding = false
	# Move normally
	else:
		add_movement()
		
	if player.health <= 0:
		player.die()
	else:
		move_and_slide()
