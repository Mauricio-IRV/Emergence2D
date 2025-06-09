extends Control

@onready var lebel = $Label

func _ready() -> void:
	GameController.connect("coin_collected", on_event_coin_collected)

# Updates label when coins are collected (heart powerup)
func on_event_coin_collected (value: int):
	lebel.text = str(value)
