extends "res://addons/gut/test.gd"

const player_gd = preload("res://scripts/player.gd")
var player: Player

func before_each():
	player = Player.new()

func test_kill_player():
	player.die()
	assert_true(player.health <= 0, "Player should be dead after calling die()")
