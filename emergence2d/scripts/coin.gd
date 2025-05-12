extends Node2D

@export var value: int = 1
@export var item: invItem
var player = null
func _on_area_2d_body_entered (body):
	if body is Player:
		player = body
		GameController.coin_collected(value)
		player.collect(item)
		self.queue_free()
