extends Enemy
class_name LandEnemy

@onready var floor_raycast := $FloorRaycast
@onready var walk_audio := $WalkAudio

@export var y_jump = -250

# Add gravity to enemy
func add_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

# Update add_movement to reflect land enemies
func add_movement() -> void:
	super.add_movement()
	
	# Handle small ledges
	if is_on_wall() and is_on_floor():
		velocity = Vector2(direction * 20, y_jump)

# Update handle_chase to reflect land enemies
func handle_chase() -> void:
	super.handle_chase()
	velocity.x = 4 * speed * direction
	walk_audio.pitch_scale = 0.5
	walk_audio.volume_db = 15

# Update handle_chase_stop
func handle_chase_stop(in_chase_range: bool) -> void:
	if not in_chase_range or not floor_raycast.is_colliding():
		chase = false
		sprite.animation = "default"
		walk_audio.pitch_scale = 0.82
		walk_audio.volume_db = 10

# Update _physics_process to reflect land enemies
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	add_gravity(delta)
	
	# If rebounding, force in opposite direction
	if rebounding:
		velocity.x = move_toward(velocity.x, 0, 1000 * delta)
		if abs(velocity.x) < 30: rebounding = false
	# Move normally
	else:
		add_movement()
