extends Enemy
class_name FlyingEnemy

'''
Defines a flying enemy class that all flying enemies are derived from
'''

# Constant declarations (for context)
const GRAVITY = 500.0
const MAX_FALL_SPEED = 300.0
const HORIZONTAL_VELOCITY_DAMPING = 1000
const REBOUND_VELOCITY_STOP_THRESHOLD = 30
const VERTICAL_CHASE_MULTIPLIER = 2

# Update default_behavior
func default_behavior() -> void:
	velocity.y = (init_pos.y - position.y) * VERTICAL_CHASE_MULTIPLIER

# Update handle_chase_stop
func handle_chase_stop(in_chase_range: bool) -> void:
	if in_chase_range:
		chase = true
	elif not in_chase_range and not rebounding:
		chase = false

# Handle chase
func handle_chase() -> void:
	super.handle_chase()
	var vertical_offset = clamp(player.position.y - position.y, -y_chase_range, y_chase_range)
	velocity.y = vertical_offset * VERTICAL_CHASE_MULTIPLIER

# Handle patrol
func handle_patrol() -> void:
	direction = 1 if position.x < (init_pos.x + patrol_range[0]) else -1
	sprite.animation = "default"
	sprite.flip_h = direction == 1
	velocity.y = (init_pos.y - position.y) * VERTICAL_CHASE_MULTIPLIER

# Update _physics_process
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if rebounding:
		velocity.x = move_toward(velocity.x, 0, HORIZONTAL_VELOCITY_DAMPING * delta)
		velocity.y = clamp(velocity.y + GRAVITY * delta, -MAX_FALL_SPEED, MAX_FALL_SPEED)
		if abs(velocity.x) < REBOUND_VELOCITY_STOP_THRESHOLD:
			rebounding = false
	else:
		# Reset vertical motion unless rebounding
		velocity.y = 0
		add_movement()
