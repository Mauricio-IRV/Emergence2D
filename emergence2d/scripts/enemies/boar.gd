extends LandEnemy

# Define attributes for boar enemy instance
func _ready():
	super._ready()
	patrol_range = [-80, 80]
	direction = 1
	speed = 40
	y_chase_range = 25
	x_chase_range = 250
	l_collision_range = 32
	r_collision_range = 28
	attack_damage = 20
