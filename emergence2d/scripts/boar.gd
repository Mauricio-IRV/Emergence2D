extends CharacterBody2D

@onready var player = $"../../Player"
@onready var boar = $AnimatedSprite2D
@onready var floorRaycast = $FloorRaycast
const SPEED = 40.0
const PATROL_RANGE = [-80, 80]

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
	
	# Handle case where not on same platform... so don't chase
	if y_dist > 20:
		chase = false
		boar.animation = "walk"
	
	# Handle Player Collision (Rebound & Damage)
	if position.distance_to(player.position) <= 28 and direction == -1 or position.distance_to(player.position) <= 33 and direction == 1:
		# Reduced initial force for smoother rebound
		velocity = Vector2(-direction * 400, -100)
		rebounding = true
		player.health -= 10
	# Handle Chase
	elif y_dist < 20 and position.distance_to(player.position) < 250 or chase == true:
		# Determine where to chase
		var dist_apart = player.position.x - position.x
		direction = sign(dist_apart)
		
		# Determine if to continue the chase
		if chase == true and not floorRaycast.is_colliding():
			chase = false
			direction = sign(init_pos.x - position.x)
			velocity.x = SPEED * direction
			boar.animation = "walk"
			boar.flip_h = direction == 1
		else:
		# Begin the chase
			chase = true
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
