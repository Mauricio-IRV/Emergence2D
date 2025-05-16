class_name Player 
extends CharacterBody2D
 
@onready var animatedSprite := $AnimatedSprite2D
@export var projectile_scene: PackedScene 
@export var inv:Inv

var shoot_direction: Vector2 = Vector2.ZERO
var direct_shoot_dir = Vector2.RIGHT
var alive = true
var can_shoot = true
var shoot_cooldown = 0.0025 
var time_since_last_shot = 0.0

# seconds of forgiveness after falling
@export var coyote_time := 0.15
var coyote_timer := 0.0

@export var health := 100
const SPEED := 300.0
const JUMP_VELOCITY := -315.0

var hearts_list: Array[TextureRect]

func _ready() -> void:
	init_hearts()

func take_damage(amount):
	if health > 0:
		health -= amount
		if health < 0: health = 0

func init_hearts():
	var hearts_parent = get_node_or_null("health_bar/HBoxContainer")
	if hearts_parent == null:
		push_error("Could not find 'health_bar/HBoxContainer' in Player node!")
		return
	
	hearts_list.clear()
	for child in hearts_parent.get_children():
		hearts_list.append(child)


func update_heart_display():
	if hearts_list.is_empty():
		push_error("Cannot update heart display: hearts_list is empty!")
		return
	
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health / 10

	if hearts_list.size() > 0:
		var heart_anim = hearts_list[0].get_child(0)
		if heart_anim and heart_anim.has_method("play"):
			if health == 10:
				heart_anim.play("beating")
			elif health > 10:
				heart_anim.play("idle")

	if health <= 0:
		alive = false
		print("Murdered... Defeated")

func heal():
	health += 10
	update_heart_display()
	print ("somehow, you managed to heal yourself!!! Good for you dude")

func _physics_process(delta: float) -> void:
	time_since_last_shot += delta
	var directionX := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up", "ui_down")
	
	# FIRST: Handle aiming input (Shift + WASD)
	if Input.is_action_pressed("shoot_ready_up") or Input.is_action_pressed("shoot_ready_down") or Input.is_action_pressed("shoot_ready_left") or Input.is_action_pressed("shoot_ready_right"):
		if Input.is_action_pressed("shoot_ready_up"):
			shoot_direction = Vector2.UP
		elif Input.is_action_pressed("shoot_ready_down"):
			shoot_direction = Vector2.DOWN
		elif Input.is_action_pressed("shoot_ready_left"):
			shoot_direction = Vector2.LEFT 
		elif Input.is_action_pressed("shoot_ready_right"):
			shoot_direction = Vector2.RIGHT
		
		# Handle shooting
		if Input.is_action_just_pressed("attack"):
			if shoot_direction == Vector2.RIGHT:
				if can_shoot:
					animatedSprite.flip_h  = false
					shoot("attack_horizontal")
					shoot_direction = Vector2.ZERO 
					can_shoot = false
					time_since_last_shot = 0.0
				else:
					if time_since_last_shot >= shoot_cooldown:
						can_shoot = true
						
			elif shoot_direction == Vector2.UP:
				if can_shoot: 
					animatedSprite.flip_h = false
					shoot("attack_up")
					shoot_direction = Vector2.ZERO
					can_shoot = false
					time_since_last_shot = 0.0
				else:
					if time_since_last_shot >= shoot_cooldown:
						can_shoot = true 
			elif shoot_direction == Vector2.LEFT:
				if can_shoot:
					animatedSprite.flip_h = true
					shoot("attack_horizontal")
					shoot_direction = Vector2.ZERO
					time_since_last_shot = 0.0 
					can_shoot =  false
				else:
					if time_since_last_shot >= shoot_cooldown:
						can_shoot = true
				

		# While aiming, stop player movement
		velocity.x = move_toward(velocity.x, 0, SPEED)
	elif Input.is_action_just_pressed("attack"):
		if shoot_direction == Vector2.RIGHT or shoot_direction == Vector2.LEFT:
			if can_shoot:
				print ("Must be a success shooting horizontal")
				shoot("attack_horizontal")
				time_since_last_shot = 0.0
				can_shoot = false 
			else:
				if time_since_last_shot >= shoot_cooldown:
					can_shoot = true
		elif shoot_direction == Vector2.UP:
			if can_shoot:
				shoot("attack_up")
				time_since_last_shot = 0.0
				can_shoot = false
			else:
				if time_since_last_shot >= shoot_cooldown:
					can_shoot = true
	else:
		# Coyote time logic
		if is_on_floor():
			coyote_timer = coyote_time
		else:
			coyote_timer = max(coyote_timer - delta, 0)

		# Add gravity
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump
		if Input.is_action_just_pressed("ui_up") and (is_on_floor() or coyote_timer > 0):
			velocity.y = JUMP_VELOCITY
			coyote_timer = 0 # prevent double jumping during coyote

		# Handle Crouch
		if Input.is_action_just_pressed("ui_down"):
			velocity.y = -(JUMP_VELOCITY/2)
			shoot_direction = Vector2.DOWN

		# Handle jump
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Handle crouch
		if Input.is_action_just_pressed("ui_down"):
			velocity.y = -(JUMP_VELOCITY/2)
			shoot_direction = Vector2.DOWN

		if directionX:
			velocity.x = directionX * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# Animation Handling
		if velocity.y > 350:
			fall_animation()
		else:
			if directionX > 0:
				animatedSprite.animation = "run"
				animatedSprite.flip_h = false
				shoot_direction = Vector2.RIGHT
				if Input.is_action_just_pressed("attack"):
					shoot("attack_horizontal")
			elif directionX < 0:
				animatedSprite.animation = "run"
				animatedSprite.flip_h = true
				shoot_direction = Vector2.LEFT
				if Input.is_action_just_pressed("attack"):
					shoot("attack_horizontal")
			elif directionY < 0:
				animatedSprite.animation = "jump"
				if Input.is_action_just_pressed("attack"):
					shoot_direction = Vector2.UP
					shoot("attack_up")
			elif directionY > 0:
				animatedSprite.animation = "crouch"
				if Input.is_action_just_pressed("attack"):
					shoot_direction = Vector2.DOWN
					shoot("attack_down")
			else:
				animatedSprite.animation = "idle"
				#print_stack()

	move_and_slide()

func shoot(dir) -> void:
	animatedSprite.animation = dir
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	projectile.setup(shoot_direction)

func fall_animation():
	animatedSprite.animation = "crouch"

func die():
	reset_scene()

func reset_scene():
	get_tree().reload_current_scene()

func collect (item):
	inv.insert(item)
