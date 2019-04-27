extends Area2D

export var active = false


func _on_Exit_body_entered(body):
	if active:
		LevelControler.switch_to_next_level()	