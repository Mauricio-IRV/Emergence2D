extends CharacterBody2D

@onready var player = $"../../Player"
@onready var boar = $AnimatedSprite2D

const SPEED = 40.0
const PATROL_RANGE = [-80, 80]

var health = 1
var direction = 1
var init_pos = Vector2()

func add_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func add_movement() -> void:
	velocity.x = SPEED * direction

	if position.x < (init_pos.x + PATROL_RANGE[0]):
		direction = 1
		boar.animation = "walk"
		boar.flip_h = true
		
	elif position.x > (init_pos.x + PATROL_RANGE[1]):
		direction = -1
		boar.animation = "walk"
		boar.flip_h = false

func _physics_process(delta: float) -> void:
	add_gravity(delta)
	add_movement()
	move_and_slide()
