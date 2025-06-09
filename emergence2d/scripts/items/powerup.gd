extends Node2D

@export var value: int = 1
@export var item: invItem

@onready var hot = get_node("../../CanvasLayer/hotbar")
@onready var player = get_node ("../../Player")

# Handles player pickup of a coin item (for fireball tscn & icon).
func _on_area_2d_body_entered (body):
	if body.name == "Player":
		hot.update_bolt_count()
		PickupAudio.play()
		GameController.powerup_collected(value)
		body.collect(item)
		self.queue_free()
