extends Control
class_name hotbar

'''
Manages the hotbar UI, tracking inventory items (hearts and bolts which represent fireball cooldown powerups),
populates the hotbar accordingly and updates its counts and visuals in its corresponding hotbar slots
'''

@onready var vbox := $VBoxContainer
var hotbar_slots := []

var inventory = {
	"heart": {"count": 0, "icon": preload("res://assets/Inventory/heart.png"), "name": "Heart"},
	"bolt": {"count": 0, "icon": preload("res://assets/Inventory/fast_fire.png"), "name": "Bolt"},
	"empty": {"count":null, "icon": preload("res://assets/Inventory/blank.png"), "name": null}, 
	"empty2": {"count":null, "icon": preload("res://assets/Inventory/blank.png"), "name": null},
	"empty3": {"count":null, "icon": preload("res://assets/Inventory/blank.png"), "name": null},
}

func update_heart_count() -> void:
	inventory["heart"].count += 1
	_update_slot_display("heart")

func degrade_heart_count() -> void:
	inventory["heart"].count -= 1
	_update_slot_display("heart")

func update_bolt_count() -> void:
	inventory["bolt"].count += 1
	_update_slot_display("bolt")
	
func degrade_bolt_count() -> void:
	inventory["bolt"].count -= 1
	_update_slot_display("bolt")

func _update_slot_display(item_name: String) -> void:
	for slot in hotbar_slots:
		if slot.item_id == item_name:
			slot.count = inventory[item_name].count
			slot.icon = inventory[item_name].icon
			slot.name_text = inventory[item_name].name
			break

func _ready():
	for item_name in inventory.keys():
		var data = inventory[item_name]
		var slot = preload("res://scenes/ui/hotbar_slot.tscn").instantiate()
		slot.item_id = item_name
		if data.count != null:
			slot.count = data.count
		if data.count:
			slot.icon = data.icon
		else:
			slot.icon = inventory["empty"].icon
		if data.name != null and data.count > 0:
			slot.name_text = data.name
		
		vbox.add_child(slot)
		hotbar_slots.append(slot)
