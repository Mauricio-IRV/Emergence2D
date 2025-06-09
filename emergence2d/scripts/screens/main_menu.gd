extends Control
@onready var settings = preload("res://scenes/screens/settings.tscn")

'''
Handle Main Menu Navigation
Ex. On game start, send the player to the first level
'''

func _on_play_pressed() -> void:
	SceneManager.go_to_next_level()

func _on_settings_pressed() -> void:
	var settings_instance = settings.instantiate()
	add_child(settings_instance)

func _on_about_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/about.tscn")
