extends Node

'''
Tracks total coins and powerups collected across the game session
'''

var total_coins: int = 0
var total_power: int = 0

func coin_collected (value:int):
	total_coins += value

func powerup_collected (value:int):
	total_power += value
