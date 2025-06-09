extends "res://addons/gut/test.gd"

var player_tscn = load("res://scenes/player.tscn")

var _player_instance
var initial_health

# Instantiate necessities
func before_each():
	_player_instance = player_tscn.instantiate()
	_player_instance.set_physics_process(false)
	_player_instance.test_mode = true

	add_child(_player_instance)
	await get_tree().process_frame

	_player_instance.health = 100
	initial_health = _player_instance.health

# Cleanup
func after_each():
	if _player_instance and _player_instance.is_inside_tree():
		_player_instance.queue_free()
		_player_instance = null
	await get_tree().process_frame

# Damage Tests
func test_take_damage():
	var dmg_amount = 10
	var new_health = initial_health - dmg_amount

	_player_instance.take_damage(dmg_amount)

	assert_eq(_player_instance.health, new_health, "Player should have taken " + str(dmg_amount) + " damage")

# Player Health Tests
func test_decrease_hearts():
	var dmg_amount = 30
	var new_heart_count = int((initial_health - dmg_amount) / 10)
	var visible_heart_count = 0

	_player_instance.take_damage(dmg_amount)
	_player_instance.update_heart_display()

	for heart in _player_instance.hearts_list:
		if heart.visible:
			visible_heart_count += 1

	assert_eq(visible_heart_count, new_heart_count, "Player should have " + str(new_heart_count) + " visible hearts")

func test_heal_increases_health():
	var dmg_amount = 30
	var heal_amount = 30
	_player_instance.take_damage(dmg_amount)

	var expected_healed_health = _player_instance.health + heal_amount
	_player_instance.heal(heal_amount)

	assert_eq(_player_instance.health, expected_healed_health, "Health should have increased by " + str(heal_amount) + " to be " + str(expected_healed_health) + " after healing")

func test_heal_updates_heart_display():
	var dmg_amount = 30
	var heal_amount = 30
	_player_instance.take_damage(dmg_amount)
	_player_instance.heal(heal_amount)

	var expected_visible_hearts = int(_player_instance.health / 10)
	var visible_heart_count = 0

	for heart in _player_instance.hearts_list:
		if heart.visible:
			visible_heart_count += 1

	assert_eq(visible_heart_count, expected_visible_hearts, "Heart display mismatch, expected " + str(expected_visible_hearts) + ", but there's " + str(visible_heart_count))

# Player Projectile Cooldown Tests
func test_cooldown_starts_at_100():
	var cooldown = _player_instance.cooldown_bar
	cooldown.start_cooldown()

	assert_true(cooldown.cooldown_active, "Cooldown should be active after starting")
	assert_eq(int(cooldown.value), 100, "Cooldown value should start at 100")  # Cast to int

func test_cooldown_decreases_over_time():
	var cooldown = _player_instance.cooldown_bar
	cooldown.cooldown_speed = 50
	cooldown.start_cooldown()

	cooldown._process(0.1)

	assert_lt(cooldown.value, 100.0, "Cooldown value should decrease over time")

func test_cooldown_resets_when_finished():
	var cooldown = _player_instance.cooldown_bar
	cooldown.cooldown_speed = 100
	cooldown.start_cooldown()

	while cooldown.cooldown_active:
		cooldown._process(0.1)

	assert_eq(int(cooldown.value), 100, "Cooldown should reset to 100 when finished")
	assert_false(cooldown.cooldown_active, "Cooldown should be inactive after reset")

func test_cooldown_speed_affects_duration():
	var cooldown = _player_instance.cooldown_bar
	cooldown.cooldown_speed = 10
	cooldown.start_cooldown()
	cooldown._process(0.5)
	var value_slow = cooldown.value

	cooldown.start_cooldown()
	cooldown.cooldown_speed = 50
	cooldown._process(0.5)
	var value_fast = cooldown.value

	assert_lt(value_fast, value_slow, "Faster cooldown speed should result in lower value after same time")
