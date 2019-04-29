extends Area2D

export var active = false


func _on_Exit_body_entered(body):
	if active:
		get_node("/root/Level/AnimationPlayer").play("NextLevel")