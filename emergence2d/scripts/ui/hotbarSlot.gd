extends Panel

'''
Represents a single hotbar slot UI element.
Manages displaying the item icon, count, and name.
Handles player input for using items (healing or projectile fireball cooldown) based on hotbar keys
'''

@onready var button = $IconButton
@onready var player := get_tree().get_current_scene().get_node_or_null("Player")

@onready var icon_button = $IconButton
@onready var numpad_label = $IconButton/Numpad
@onready var count_label = $Count
@onready var name_label = $Names

@export var item_id: String
@export var name_text: String
@onready var hot_bar = get_node("../../")

const HEART_HEAL_AMOUNT = 20
const COOLDOWN_RATE = 80

# Set item count and update count label display and position
@export var count: int:
	set(value):
		count = value
		if count_label:
			count_label.text = str(value)
			count_label.anchor_right = 1
			count_label.anchor_bottom = 1

# Set icon button appearance and position
@export var icon: Texture:
	set(value):
		icon = value
		if icon_button:
			icon_button.texture_normal = value
			icon_button.custom_minimum_size = Vector2(32, 32)
			icon_button.anchor_right = 0.50
			icon_button.anchor_bottom = 0.55
			
			# Clear the numpad label if an icon is assigned
			if numpad_label and icon:
				numpad_label.text = ""

func get_hotbar() -> hotbar:
	var node = get_parent()
	while node != null:
		if node is hotbar:
			return node
		node = node.get_parent()
	return null

func _ready():
	# If count / name_text are set, update them
	if count:
		count_label.text = str(count)
	if name_text:
		name_label.text = name_text

	# Apply icon to texture button
	button.texture_normal = icon

	# Update numpad label based on index
	var index = get_index()
	numpad_label.text = str(index + 1)

func _input(event):
	if event.is_action_pressed("hotbar_slot_1"):
		if hot_bar.inventory["heart"].count > 0:
			player.heal(HEART_HEAL_AMOUNT)
			hot_bar.degrade_heart_count()

	if event.is_action_pressed("hotbar_slot_2"):
		if hot_bar.inventory["bolt"].count > 0:
			player.cooldown_bar.cooldown_speed += COOLDOWN_RATE
			hot_bar.degrade_bolt_count()
