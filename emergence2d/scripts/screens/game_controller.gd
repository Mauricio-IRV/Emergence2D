extends Node

var total_coins: int = 0
var total_power: int = 0
func coin_collected (value:int):
	total_coins += value
	#EventController.emit_signal("coin_collected", total_coins)
func powerup_collected (value:int):
	total_power += value
