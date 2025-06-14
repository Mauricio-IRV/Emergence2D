extends CharacterBody2D
class_name Player

'''
Handles player movement, shooting, health, animation, and inventory.
'''

# Scenes
@onready var animatedSprite := $AnimatedSprite2D
@export var projectile_scene: PackedScene 
@export var inv:Inv = preload('res://resources/players_inv.tres')
@export var test_mode := false

# Projectile Variables
var shoot_direction: Vector2 = Vector2.ZERO
var last_valid_shoot_direction: Vector2 = Vector2.RIGHT
var direct_shoot_dir = Vector2.RIGHT
var projectile_offset_y = 0
@onready var cooldown_bar = $CooldownBar

# Seconds of forgiveness after falling (coyote time)
@export var coyote_time := 0.15
var coyote_timer := 0.0

# Player properties
@onready var damaged_audio = $DamagedAudio
@export var health := 100
const JUMP_VELOCITY := -308.0
const SPEED := 280.0
@export var hearts_list: Array[TextureRect]
var taking_dmg = false

# Timing constants
const DAMAGE_COOLDOWN_TIME := 0.15
const DEATH_DELAY_TIME := 0.4

# Projectile offset
const PROJECTILE_OFFSET_Y_DEFAULT := 15

# Movement / Animation thresholds
const VELOCITY_Y_THRESHOLD := 350
const JUMP_DOWN_VELOCITY_DIVISOR := 2
const VELOCITY_DAMPING := SPEED  # Used for velocity slowdown when no input

'''
Handle Health
'''
func init_hearts():
	var hearts_parent = get_node_or_null("health_bar/HBoxContainer")
	if hearts_parent == null:
		push_error("Could not find 'health_bar/HBoxContainer' in Player node!")
		return
	
	for child in hearts_parent.get_children():
		hearts_list.append(child)

func update_heart_display():
	if hearts_list.is_empty():
		push_error("Cannot update heart display: hearts_list is empty!")
		return

	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health / 10.0

	if hearts_list.size() > 0:
		var heart_anim = hearts_list[0].get_child(0)
		if heart_anim and heart_anim.has_method("play"):
			if health == 10:
				heart_anim.play("beating")
			elif health > 10:
				heart_anim.play("idle")

func heal(amount):
	health = min(health + amount, 100)
	update_heart_display()

func take_damage(amount):
	taking_dmg = true
	if health > 0:
		health -= amount
	damaged_audio.play()
	await get_tree().create_timer(DAMAGE_COOLDOWN_TIME).timeout
	if (health - amount) <= 0:
		await get_tree().create_timer(DEATH_DELAY_TIME).timeout
	taking_dmg = false

'''
Handle Projectiles
'''
func is_aiming() -> bool:
	return Input.is_action_pressed("shoot_ready_up") or Input.is_action_pressed("shoot_ready_down") or Input.is_action_pressed("shoot_ready_left") or Input.is_action_pressed("shoot_ready_right")

func handle_aiming_input():
	projectile_offset_y = PROJECTILE_OFFSET_Y_DEFAULT
	if Input.is_action_pressed("shoot_ready_up"):
		shoot_direction = Vector2.UP
	elif Input.is_action_pressed("shoot_ready_down"):
		shoot_direction = Vector2.DOWN
	elif Input.is_action_pressed("shoot_ready_left"):
		shoot_direction = Vector2.LEFT
	elif Input.is_action_pressed("shoot_ready_right"):
		shoot_direction = Vector2.RIGHT
	else:
		shoot_direction = Vector2.ZERO

	if shoot_direction != Vector2.ZERO:
		last_valid_shoot_direction = shoot_direction

func handle_attack():
	if not cooldown_bar.is_cooldown_over():
		return
	else:
		cooldown_bar.start_cooldown()

	var actual_shoot_direction: Vector2
	
	if shoot_direction != Vector2.ZERO:
		actual_shoot_direction = shoot_direction
	else:
		actual_shoot_direction = last_valid_shoot_direction

	match actual_shoot_direction:
		Vector2.RIGHT:
			animatedSprite.flip_h = false
			shoot("attack_horizontal", actual_shoot_direction)
		Vector2.LEFT:
			animatedSprite.flip_h = true
			shoot("attack_horizontal", actual_shoot_direction)
		Vector2.UP:
			shoot("attack_up", actual_shoot_direction)
		Vector2.DOWN:
			shoot("crouch", actual_shoot_direction)

func shoot(animation_name: String, direction: Vector2) -> void:
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)

	projectile.global_position = global_position
	projectile.setup(direction, projectile_offset_y)
	animatedSprite.animation = animation_name
	projectile_offset_y = 0

'''
Handle Movement
'''
func handle_animation(directionX: float, directionY: float):
	if velocity.y > VELOCITY_Y_THRESHOLD:
		animatedSprite.animation = "attack"
	elif taking_dmg:
		animatedSprite.animation = "death"
	elif directionX > 0:
		animatedSprite.animation = "run"
		animatedSprite.flip_h = false
		shoot_direction = Vector2.RIGHT
	elif directionX < 0:
		animatedSprite.animation = "run"
		animatedSprite.flip_h = true
		shoot_direction = Vector2.LEFT
	elif directionY < 0:
		animatedSprite.animation = "jump"
	elif directionY > 0:
		animatedSprite.animation = "crouch"
	elif directionX == 0:
		animatedSprite.animation = "idle"
	
	move_and_slide()

func handle_movement_and_animation(directionX: float, directionY: float, delta: float):
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer = max(coyote_timer - delta, 0)

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("move_up") and (is_on_floor() or coyote_timer > 0):
		velocity.y = JUMP_VELOCITY
		coyote_timer = 0
	elif Input.is_action_just_pressed("move_down"):
		velocity.y = -(JUMP_VELOCITY / JUMP_DOWN_VELOCITY_DIVISOR)

	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, VELOCITY_DAMPING)

	handle_animation(directionX, directionY)

'''
Main
'''
func _ready() -> void:
	init_hearts()
	cooldown_bar.init_cooldown()

func collect(item):
	inv.insert(item)

func die():
	reset_scene()

func reset_scene():
	SceneManager.go_to_loss_screen()

func _physics_process(delta: float) -> void:
	if test_mode:
		return
	var directionX := Input.get_axis("move_left", "move_right")
	var directionY := Input.get_axis("move_up", "move_down")

	if is_aiming():
		handle_aiming_input()
		if Input.is_action_just_pressed("attack"):
			handle_attack()
		projectile_offset_y = 0
		velocity.x = move_toward(velocity.x, 0, SPEED)
	elif Input.is_action_just_pressed("attack"):
		handle_attack()
	else:
		handle_movement_and_animation(directionX, directionY, delta)
