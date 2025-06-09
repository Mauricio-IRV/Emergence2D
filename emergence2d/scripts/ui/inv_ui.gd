extends Control

'''
Inventory UI Controller
Handles visibility toggling of the inventory panel and updates inventory slots
by syncing them with the player's inventory resource (`players_inv.tres`).
'''

@onready var inv: Inv =  preload('res://resources/players_inv.tres')
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
var is_open = false

func _ready ():
	inv.update.connect(update_slots)
	update_slots()
	close()

func _process (_delta):
	if Input.is_action_just_pressed ('toggle_inventory'):
		if is_open: close()
		else: open()

func close():
	visible = false
	is_open = false 

func open():
	visible = true 
	is_open = true

func update_slots():
	for i in range (min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
