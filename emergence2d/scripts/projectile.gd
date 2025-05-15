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
		pass
	elif direction == Vector2.LEFT:
		sprite.flip_h = true
		sprite.offset = Vector2(-100, 0)
	elif direction == Vector2.UP:
		sprite.rotation_degrees = -90
		sprite.offset = Vector2(15, -32)
	elif direction == Vector2.DOWN:
		sprite.rotation_degrees = 90

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("boar"):
		body.call_deferred("queue_free")
		
	if body.is_in_group("bee"):
		body.call_deferred("queue_free")
