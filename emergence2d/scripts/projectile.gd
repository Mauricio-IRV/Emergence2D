extends Area2D

'''
Controls projectile movement, direction setup, and collision handling.
'''

@export var speed: float = 400.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision := $CollisionShape2D
@onready var screen_size = get_viewport().get_visible_rect().size

var direction: Vector2 = Vector2.RIGHT

# Constants for sprite and collision offsets
const OFFSET_RIGHT = Vector2(0, -15)
const OFFSET_LEFT = Vector2(-32, -15)
const OFFSET_UP = Vector2(15, -32)
const OFFSET_DOWN = Vector2(15, -40)

# Rotation degrees for projectile when facing up/down
const ROTATION_UP = -90
const ROTATION_DOWN = 90

# Handle projectile offsets and direction setup
func setup(new_direction: Vector2, y_offset: float = 0) -> void:
	direction = new_direction
	sprite.flip_h = false
	sprite.flip_v = false
	sprite.rotation_degrees = 0

	match direction:
		Vector2.RIGHT:
			sprite.offset = OFFSET_RIGHT
			collision.position = OFFSET_RIGHT
		Vector2.LEFT:
			sprite.flip_h = true
			sprite.offset = OFFSET_LEFT
			collision.position = OFFSET_LEFT
		Vector2.UP:
			sprite.rotation_degrees = ROTATION_UP
			sprite.offset = OFFSET_UP
			collision.position = OFFSET_UP
		Vector2.DOWN:
			sprite.rotation_degrees = ROTATION_DOWN
			sprite.offset = OFFSET_DOWN
			collision.position = OFFSET_DOWN

	# Apply vertical offset (e.g. when player is standing)
	sprite.offset.y += y_offset
	collision.position.y += y_offset

# Handle projectile collisions
func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		# Maybe you want to do something here later?
		pass
	elif body.is_in_group("enemy"):
		CollisionAudio.play()
		body.call_deferred("queue_free")
		call_deferred("queue_free")
	else:
		pass

'''
Main movement
'''
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
