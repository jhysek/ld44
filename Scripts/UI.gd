extends CanvasLayer

onready var game = get_node("/root/Level")

func _on_Resume_pressed():
	$Sfx/Click.play()
	game.paused = false
	get_parent().hide()


func _on_Restart_pressed():
	$Sfx/Click.play()
	LevelControler.start_level()
	
	
func _on_Quit_pressed():
	$Sfx/Click.play()
	get_tree().change_scene("res://Scenes/Menu.tscn")

func _on_mouse_entered():
	$Sfx/Hover.play()