extends Control
var is_open = false
@onready var inv: Inv =  preload("res://players_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready ():
	#update_slots()
	close()
func _process (delta):
	if Input.is_action_just_pressed ('toggle_inventory'):
		if is_open:
			close()
		else:
			open()
func close():
	visible = false
	is_open = false 
func open():
	visible = true 
	is_open = true

#func update_slots():
	#for i in range (min(inv.items.size(), slots.size())):
		#slots[i].update(inv.items[i])
