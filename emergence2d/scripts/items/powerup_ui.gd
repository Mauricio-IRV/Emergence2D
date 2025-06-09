extends Control

@onready var lebel = $Label

func _ready() -> void:
	GameController.connect("powerup_collected", on_event_powerup_collected)

# Updates label when coins are collected (fireball powerup).
func on_event_powerup_collected (value: int):
	lebel.text = str(value)
