extends Area2D

@export var speed: float = 400.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision := $CollisionShape2D
@onready var screen_size = get_viewport().get_visible_rect().size

var direction: Vector2 = Vector2.RIGHT

# Handle projectile offsets
func setup(new_direction: Vector2, y_offset: float = 0) -> void:
	direction = new_direction
	sprite.flip_h = false
	sprite.flip_v = false
	sprite.rotation_degrees = 0

	match direction:
		Vector2.RIGHT:
			sprite.offset = Vector2(0, -15)
			collision.position = Vector2(0, -15)
		Vector2.LEFT:
			sprite.flip_h = true
			sprite.offset = Vector2(-32, -15)
			collision.position = Vector2(-32, -15)
		Vector2.UP:
			sprite.rotation_degrees = -90
			sprite.offset = Vector2(15, -32)
			collision.position = Vector2(15, -32)
		Vector2.DOWN:
			sprite.rotation_degrees = 90
			sprite.offset = Vector2(15, -40)
			collision.position = Vector2(15, -40)

	# Apply vertical offset for when sprite is standing
	sprite.offset.y += y_offset
	collision.position.y += y_offset

# Handle projectile collisions
func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		pass
	elif body.is_in_group("boar"):
		CollisionAudio.play()
		body.call_deferred("queue_free")
		call_deferred("queue_free")
	elif body.is_in_group("bee"):
		CollisionAudio.play()
		body.call_deferred("queue_free")
		call_deferred("queue_free")
	else:
		pass

'''
Main
'''
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
