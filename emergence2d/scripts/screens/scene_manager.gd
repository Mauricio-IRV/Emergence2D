extends Node

var current_level_path := ""
var previous_scene_path := ""
var final_level = 3

func go_to_scene(path: String):
	previous_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(path)

func go_to_next_level():
	var curr_level = int(get_tree().current_scene.name)
	if curr_level < final_level:		
		var next_scene_path = "res://scenes/screens/level_" + str(curr_level + 1) + ".tscn"
		get_tree().call_deferred("change_scene_to_file", next_scene_path)
		current_level_path = next_scene_path
	else:
		go_to_won_screen()

func go_to_loss_screen():
	current_level_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/screens/loss.tscn")

func go_to_won_screen():
	get_tree().call_deferred("change_scene_to_file", "res://scenes/screens/won.tscn")

func retry_level():
	print("CURR LEVEL? ", current_level_path)
	if current_level_path != "":
		get_tree().change_scene_to_file(current_level_path)
	else:
		push_error("No level path saved.")
