extends Node2D

@export var value: int = 1
@export var item: invItem

func _on_area_2d_body_entered (body):
	if body is Player:
		PickupAudio.play()
		GameController.coin_collected(value)
		body.collect(item)
		self.queue_free()
