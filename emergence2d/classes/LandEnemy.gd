extends Enemy
class_name LandEnemy

'''
Defines a land enemy class that all walking enemies are derived from
'''

@onready var floor_raycast := $FloorRaycast
@onready var walk_audio := $WalkAudio

@export var y_jump = -250  # export so instances can redefine it

# Constant declarations (for context)
const SMALL_LEDGE_PUSH = 20
const CHASE_SPEED_MULTIPLIER = 4
const WALK_AUDIO_PITCH_CHASING = 0.5
const WALK_AUDIO_VOLUME_CHASING_DB = 15
const WALK_AUDIO_PITCH_IDLE = 0.82
const WALK_AUDIO_VOLUME_IDLE_DB = 10
const REBOUND_VELOCITY_DAMPING = 1000
const REBOUND_VELOCITY_STOP_THRESHOLD = 30

# Add gravity to enemy
func add_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

# Update add_movement to reflect land enemies
func add_movement() -> void:
	super.add_movement()
	
	# Handle small ledges
	if is_on_wall() and is_on_floor():
		velocity = Vector2(direction * SMALL_LEDGE_PUSH, y_jump)

# Update handle_chase to reflect land enemies
func handle_chase() -> void:
	super.handle_chase()
	velocity.x = CHASE_SPEED_MULTIPLIER * speed * direction
	walk_audio.pitch_scale = WALK_AUDIO_PITCH_CHASING
	walk_audio.volume_db = WALK_AUDIO_VOLUME_CHASING_DB

# Update handle_chase_stop
func handle_chase_stop(in_chase_range: bool) -> void:
	if not in_chase_range or not floor_raycast.is_colliding():
		chase = false
		sprite.animation = "default"
		walk_audio.pitch_scale = WALK_AUDIO_PITCH_IDLE
		walk_audio.volume_db = WALK_AUDIO_VOLUME_IDLE_DB

# Update _physics_process to reflect land enemies
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	add_gravity(delta)
	
	# If rebounding, force in opposite direction
	if rebounding:
		velocity.x = move_toward(velocity.x, 0, REBOUND_VELOCITY_DAMPING * delta)
		if abs(velocity.x) < REBOUND_VELOCITY_STOP_THRESHOLD:
			rebounding = false
	# Move normally
	else:
		add_movement()
