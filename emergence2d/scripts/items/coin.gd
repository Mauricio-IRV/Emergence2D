extends Node2D

@export var value: int = 1
@export var item: invItem

@onready var hot = get_node("../../CanvasLayer/hotbar")

var player = null
func _on_area_2d_body_entered (body):
	if body.name == "Player":
		player = body
		hot.update_heart_count()
		PickupAudio.play()
		GameController.coin_collected(value)
		player.collect(item)
		self.queue_free()
