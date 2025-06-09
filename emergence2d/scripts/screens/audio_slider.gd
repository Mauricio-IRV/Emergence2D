extends HSlider

@export var bus: String 
@export var index: int 

func  _ready() -> void:
	index = AudioServer.get_bus_index(bus)
	value_changed.connect(_on_value_changed)
	value = db_to_linear(AudioServer.get_bus_volume_db(index))

func _on_value_changed(amount:float):
	AudioServer.set_bus_volume_db(index, linear_to_db(amount))
