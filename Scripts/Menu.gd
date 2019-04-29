extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			LevelControler.start_level()

func _on_Button_pressed():
	$Sfx/Click.play()
	LevelControler.start_level()

func _on_Start_mouse_entered():
	$Sfx/Hover.play()