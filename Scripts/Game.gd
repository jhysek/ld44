extends Node2D

var paused = false

onready var pause_menu = $UI/Wrapper/PauseMenu

func _ready():
	set_process_input(true)	

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_R:
			LevelControler.start_level()
			
		if event.pressed and event.scancode == KEY_ESCAPE:
			print("ESCAPE")
			if !paused:
				pause_menu.show()
				paused = true
			else:
				pause_menu.hide()
				paused = false
			
func next_level():
	LevelControler.switch_to_next_level()
		