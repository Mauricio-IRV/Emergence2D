extends FlyingEnemy

# Define attributes for bee enemy instance
func _ready():
	super._ready()
	patrol_range = [-40, 40]
	direction = 1
	speed = 100
	y_chase_range = 50
	x_chase_range = 100
	l_collision_range = 22
	r_collision_range = 22
	attack_damage = 20
