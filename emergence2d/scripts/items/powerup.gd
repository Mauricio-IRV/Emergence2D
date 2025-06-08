extends Node2D

@export var value: int = 1
@export var item: invItem

@onready var hot = get_node("../../CanvasLayer/hotbar")

var player = null
@onready var Player = get_node ("../../Player")

func _process(delta: float) -> void:
	_listen_to_hot_key()
	
func _listen_to_hot_key():
	if Input.is_action_just_pressed("power_up"):
		print (hot.inventory["bolt"].count)
		if hot.inventory["bolt"].count > 0:
			Player.cooldown.cooldown_value  *= 5
			Player.cooldown.cooldown_speed /= 2
			hot.degrade_bolt_count()
			
func _on_area_2d_body_entered (body):
	if body.name == "Player":
		player = body
		hot.update_bolt_count()
		PickupAudio.play()
		GameController.powerup_collected(value)
		player.collect(item)
		self.queue_free()
