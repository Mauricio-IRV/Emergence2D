extends "res://addons/gut/test.gd"

var level_tscn = load("res://scenes/level_1.tscn")
var player_tscn = load("res://scenes/player.tscn")
var player_gd = load("res://scripts/player.gd")

var _player: Player
var _player_instance
var initial_health

func before_each():
	_player = player_gd.new()
	_player_instance = player_tscn.instantiate()
	add_child(_player_instance)
	await get_tree().process_frame

	initial_health = _player.health

func test_take_damage():
	var dmg_amount = 10
	var new_health = initial_health - dmg_amount
	
	# Damage player and assert the amount of dmg taken is accurate
	_player.take_damage(10)
	assert_true(_player.health == new_health, "Player should have taken " + str(dmg_amount) + " damage")

func test_decrease_hearts():
	var dmg_amount = 30
	var new_heart_count = int(10 - (dmg_amount / 10))
	var visible_heart_count = 0

	_player_instance.take_damage(dmg_amount)
	_player_instance.update_heart_display()

	for i in range(_player_instance.hearts_list.size()):
		if _player_instance.hearts_list[i].visible:
			visible_heart_count += 1
	
	assert_eq(visible_heart_count, new_heart_count, "Player should have " + str(new_heart_count) + " visible hearts")

func test_heal_increases_health():
	var dmg_amount = 30
	var expected_healed_health = initial_health - dmg_amount + 10
	
	# Apply damage and then heal
	_player_instance.take_damage(dmg_amount)
	_player_instance.heal()

	# Check if health increased correctly
	assert_eq(_player_instance.health, expected_healed_health, "Health should have increased by 10 after healing")

func test_heal_updates_heart_display():
	var dmg_amount = 30
	var expected_visible_hearts = int((initial_health - dmg_amount + 10) / 10)  # Expected heart count after healing
	var visible_heart_count = 0
	
	# Apply damage and then heal
	_player_instance.take_damage(dmg_amount)
	_player_instance.heal()

	# Check if heart display is updated
	for heart in _player_instance.hearts_list:
		if heart.visible:
			visible_heart_count += 1
	
	# Check if the visible heart count matches the expected value
	assert_eq(visible_heart_count, expected_visible_hearts, "Heart display should match healed health")
