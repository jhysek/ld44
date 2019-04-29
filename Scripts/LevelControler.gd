extends Node

var levels = [
	"res://Levels/Level0.tscn",
	"res://Levels/Level1.tscn",	
	"res://Levels/Level2.tscn",	
	"res://Levels/Level3.tscn",	
	"res://Levels/Level5.tscn",	
	"res://Levels/Level6.tscn",	
]

var current_level = 0

func current_level_name():
	return levels[current_level]

func start_level():
	get_tree().change_scene(current_level_name())
		
func switch_to_next_level():
	if current_level < levels.size() - 1:
		current_level += 1
		start_level()
	else:
		get_tree().change_scene("res://Scenes/Finished.tscn")