extends Control

# Handle closing about page
func _on_close_pressed() -> void:
	get_tree().change_scene_to_file ("res://scenes/screens/main_menu.tscn")
