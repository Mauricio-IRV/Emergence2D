extends CollisionPolygon2D

# Handle level loading & checkpoints on door entry
func _on_doorway_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		SceneManager.go_to_next_level()
