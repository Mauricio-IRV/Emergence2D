extends Button

# Handle main menu button
func _pressed():
	get_tree().change_scene_to_file("res://scenes/screens/main_menu.tscn")
