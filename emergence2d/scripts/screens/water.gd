extends CollisionPolygon2D

const DELAY = 0.3

func _on_hazards_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(DELAY).timeout
		get_tree().change_scene_to_file("res://scenes/screens/loss.tscn")
