extends Panel
@onready var button = $IconButton
@onready var player := get_tree().get_current_scene().get_node_or_null("Player")

@onready var icon_button = $IconButton
@onready var count_label = $Label
@onready var name_label = $Label2
@export var item_id: String
@export var name_text: String

@export var count: int:
	set(value):
		count = value
		if count_label:
			count_label.text = str(value)

@export var icon: Texture:
	set(value):
		icon = value
		if icon_button:
			icon_button.texture_normal = value
			icon_button.custom_minimum_size = Vector2(32, 32)


func get_hotbar() -> hotbar:
	var node = get_parent()
	while node != null:
		if node is hotbar:
			return node
		node = node.get_parent()
	return null

func _process(delta):
	handle_hot_keys()	

func _ready():
	count_label.text = str(count)
	name_label.text = name_text
	button.texture_normal = icon

func update_display(element):
	if count > 0:
		if name_label.text == "Health" and element == "Health":
			print("Healing player")
			player.heal()
			count -= 1
			count_label.text = str(count)

			var hot = get_hotbar()
			if hot:
				hot.inventory["heart"].count = count  # keep inventory in sync


func handle_hot_keys ():
	if Input.is_action_just_pressed("get_health"):
		player.update_heart_display()
		update_display("Health")
