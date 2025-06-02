extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pause_game()

func resume ():
	get_tree().paused =  false 
	hide_screen()

func pause():
	get_tree().paused =  true 	
	show_screen()

func pause_game ():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree ().paused == true:
		resume() 

func show_screen(): 
	visible = true
	
func hide_screen():
	visible = false
	
func _on_resume_pressed() -> void:
	hide_screen()
	resume()

func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://scenes/screens/main_menu.tscn")
