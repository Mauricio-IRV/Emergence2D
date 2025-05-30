extends CharacterBody2D
class_name Enemy

# OnReady Variables
@onready var player := get_tree().get_current_scene().get_node_or_null("Player")
@onready var sprite := $AnimatedSprite2D

# Enemy Dependent Variables
@export var patrol_range := [-0, 0]
@export var direction := 0
@export var speed := 0.0
@export var y_chase_range := 0
@export var x_chase_range := 0
@export var l_collision_range := 0
@export var r_collision_range := 0
@export var attack_damage := 0

# In-game Dependence Variables
var chase := false
var rebounding := false
var health := 1
var init_pos := Vector2()

# On Instantiation (i.e. ready)
func _ready() -> void:
	init_pos = position

func add_movement() -> void:
	velocity.x = speed * direction
	
	# Determine if in chase range
	var y_dist = abs(player.position.y - position.y)
	var in_chase_range = (
		y_dist < y_chase_range and 
		position.distance_to(player.position) < x_chase_range
	)
	
	# Handle when to stop chasing
	handle_chase_stop(in_chase_range)

	# Handle player collision (rebound & damage), chase, patrol, default
	if position.distance_to(player.position) <= l_collision_range and direction == -1 or position.distance_to(player.position) <= r_collision_range and direction == 1: 
		handle_player_collision(attack_damage)
	elif chase or in_chase_range: 
		handle_chase()
	elif position.x < (init_pos.x + patrol_range[0]) or position.x > (init_pos.x + patrol_range[1]): 
		handle_patrol()
	else:
		default_behavior()

# Handle default behavior
func default_behavior() -> void:
	pass

# Handle chase stop (depends on subclass)
func handle_chase_stop(_in_chase_range: bool) -> void:
	pass

# Handle player collision
func handle_player_collision(damage_amount) -> void:
	rebounding = true
	velocity = Vector2(-direction * 400, -100)
	player.take_damage(damage_amount)
	player.update_heart_display()

# Handle chase
func handle_chase() -> void:
	chase = true
	var dist_apart = player.position.x - position.x
	direction = sign(dist_apart)
	sprite.animation = "attack"
	sprite.flip_h = direction > 0

# Handle patrol
func handle_patrol() -> void:
	direction = 1 if position.x < (init_pos.x + patrol_range[0]) else -1
	sprite.animation = "default"
	sprite.flip_h = direction > 0

# Handle enemy physics
func _physics_process(_delta: float) -> void:	
	if player.health <= 0:
		player.die()
	else:
		move_and_slide()
