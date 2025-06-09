extends Button

# Handle restart game button
func _pressed():
	get_tree().change_scene_to_file("res://scenes/screens/level_1.tscn")
