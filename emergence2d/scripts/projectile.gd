extends Area2D

@export var speed: float = 400.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var screen_size = get_viewport().get_visible_rect().size

var direction: Vector2 = Vector2.RIGHT

func setup(new_direction: Vector2) -> void:
	direction = new_direction
	# Reset flips
	sprite.flip_h = false
	sprite.flip_v = false
	sprite.rotation_degrees = 0

	# Set flips or rotation
	if direction == Vector2.RIGHT:
		sprite.offset = Vector2(-10, -20)
		pass
	elif direction == Vector2.LEFT:
		sprite.offset = Vector2(-100, -20)
		sprite.flip_h = true
	elif direction == Vector2.UP:
		sprite.rotation_degrees = -90
		sprite.offset = Vector2(30, 3)
	elif direction == Vector2.DOWN:
		sprite.rotation_degrees = 90

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

	#if position.x < -100 or position.x > screen_size.x + 100 or position.y < -100 or position.y > screen_size.y + 100:
		#queue_free()

func _on_body_entered(body: Node) -> void:
	print ("Something got hit")
