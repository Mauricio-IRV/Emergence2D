extends Control

@onready var lebel = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameController.connect("powerup_collected", on_event_powerup_collected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_event_powerup_collected (value: int):
	lebel.text = str(value)
