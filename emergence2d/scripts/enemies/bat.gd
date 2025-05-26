extends FlyingEnemy

# Define Attributes
func _ready():
	super._ready()
	patrol_range = [-40, 40]
	direction = 1
	speed = 200
	y_chase_range = 100
	x_chase_range = 100
	l_collision_range = 22
	r_collision_range = 22
	attack_damage = 10

func handle_patrol() -> void:
	sprite.animation = "default"
	sprite.flip_h = false
	sprite.play()
