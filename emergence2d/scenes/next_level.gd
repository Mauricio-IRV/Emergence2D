extends CollisionPolygon2D

func _on_doorway_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var next_scene_path = "res://scenes/level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn"
		get_tree().call_deferred("change_scene_to_file", next_scene_path)
		print(next_scene_path)
