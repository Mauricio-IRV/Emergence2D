extends HSlider

@export var bus: String 

@export var index: int 
@onready var settings = $"../.."
func  _ready() -> void:
	index = AudioServer.get_bus_index(bus)
	value_changed.connect(_on_value_changed)
	value = db_to_linear(AudioServer.get_bus_volume_db(index))
func _on_value_changed(value:float):
	AudioServer.set_bus_volume_db(index, linear_to_db(value))


func _on_button_pressed() -> void:
	settings.visible = false
