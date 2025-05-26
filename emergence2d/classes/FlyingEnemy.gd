extends Enemy
class_name FlyingEnemy

var gravity = 500.0
var max_fall_speed = 300.0

# Update default_behavior
func default_behavior() -> void:
	velocity.y = (init_pos.y - position.y) * 2

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
	velocity.y = vertical_offset * 2

# Handle patrol
func handle_patrol() -> void:
	direction = 1 if position.x < (init_pos.x + patrol_range[0]) else -1
	sprite.animation = "default"
	sprite.flip_h = direction == 1
	velocity.y = (init_pos.y - position.y) * 2

# Update _physics_process
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if rebounding:
		velocity.x = move_toward(velocity.x, 0, 1000 * delta)
		velocity.y = clamp(velocity.y + gravity * delta, -max_fall_speed, max_fall_speed)
		if abs(velocity.x) < 30:
			rebounding = false
	else:
		# Reset vertical motion unless rebounding
		velocity.y = 0
		add_movement()
