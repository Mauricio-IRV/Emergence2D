extends CollisionShape2D

const DELAY = 0.5

func _on_water_hazard_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(DELAY).timeout
		get_tree().reload_current_scene()
