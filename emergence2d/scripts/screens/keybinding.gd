extends MarginContainer

@onready var input_key_scene = preload("res://scenes/screens/input_button.tscn")
@onready var actions_container = $VBoxContainer/ScrollContainer/ActionList
@onready var parent_settings = $"../"

var remap_active = false
var current_action = null
var current_button = null

var key_bindings = {
	"move_left": "Move Left",
	"move_right": "Move Right",
	"move_down": "Crouch",
	"attack": "Shoot",
	"move_up": "Jump",
	"shoot_ready_left": "Aim Left",
	"shoot_ready_right": "Aim Right",
	"shoot_ready_down": "Aim Down",
	"shoot_ready_up": "Aim Up",
	"hotbar_slot_1": "Hotbar 1",
	"hotbar_slot_2": "Hotbar 2",
	"hotbar_slot_3": "Hotbar 3",
	"hotbar_slot_4": "Hotbar 4",
	"hotbar_slot_5": "Hotbar 5",
}

func _ready():
	_refresh_action_buttons()

func _refresh_action_buttons():
	InputMap.load_from_project_settings()
	for child in actions_container.get_children():
		child.queue_free()
	
	for action_name in key_bindings.keys():
		var btn_instance = input_key_scene.instantiate()
		var label_action = btn_instance.find_child("LabelAction")
		var label_input = btn_instance.find_child("LabelInput")
		
		label_action.text = key_bindings[action_name]
		
		var assigned_events = InputMap.action_get_events(action_name)
		if assigned_events.size() > 0:
			label_input.text = assigned_events[0].as_text().trim_suffix(" (Physical)")
		else:
			label_input.text = ""
		
		actions_container.add_child(btn_instance)
		btn_instance.pressed.connect(_on_button_pressed.bind(btn_instance, action_name))

func _on_button_pressed(button, action_name):
	if remap_active:
		return
	
	remap_active = true
	current_action = action_name
	current_button = button
	button.find_child("LabelInput").text = "Press any key..."

func _input(event):
	if remap_active:
		if event is InputEventKey and event.pressed and not event.echo:
			InputMap.action_erase_events(current_action)
			
			var event_copy = event.duplicate()
			event_copy.echo = false
			
			InputMap.action_add_event(current_action, event_copy)
			_update_button_label(current_button, event_copy)
			
			_clear_remap_state()
			accept_event()
			
		elif event is InputEventMouseButton and event.pressed:
			if event.double_click():
				event.double_click = false
			
			InputMap.action_erase_events(current_action)
			InputMap.action_add_event(current_action, event)
			_update_button_label(current_button, event)
			
			_clear_remap_state()
			accept_event()

func _update_button_label(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")

func _clear_remap_state():
	remap_active = false
	current_action = null
	current_button = null

func _on_reset_button_pressed() -> void:
	_refresh_action_buttons()

# Exit settings
func _on_done_pressed() -> void:
	parent_settings.visible = false
