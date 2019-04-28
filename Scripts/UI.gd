extends CanvasLayer

onready var game = get_node("/root/Level")

func _on_Resume_pressed():
	game.paused = false
	get_parent().hide()


func _on_Restart_pressed():
	LevelControler.start_level()
	
	
func _on_Quit_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")