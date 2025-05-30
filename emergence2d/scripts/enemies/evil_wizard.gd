extends LandEnemy

# Define Attributes
func _ready():
	super._ready()
	patrol_range = [-100, 100]
	direction = 1
	speed = 50
	y_chase_range = 25
	x_chase_range = 250
	l_collision_range = 32
	r_collision_range = 28
	attack_damage = 10
	y_jump = -250
