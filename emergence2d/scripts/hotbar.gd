extends Control

@onready var player: Player = get_tree().get_first_node_in_group("player")
# Called when the node enters the scene tree for the first time.
@onready var grid_container : GridContainer = $GridContainer
func _ready() -> void:
	for button in grid_container.get_children():
		if (button is ItemButton):
			print ("button was clicked")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
