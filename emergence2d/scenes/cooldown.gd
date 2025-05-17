extends ProgressBar

var cooldown_value := 100
var cooldown_speed := 20
var cooldown_active = false

func init_cooldown():
	value = 100

func start_cooldown():
	cooldown_value = 100
	cooldown_active = true

func is_cooldown_over():
	if value == 100: return true
	else: return false

func _process(delta):
	if cooldown_active and cooldown_value > 0:
		cooldown_value -= cooldown_speed * delta
		value = max(cooldown_value, 0)
		cooldown_active = true
	elif cooldown_value == 0:
		value = 100
		cooldown_value = 100
		cooldown_active = false
