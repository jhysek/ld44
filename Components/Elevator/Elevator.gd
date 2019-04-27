extends Node2D

var active

func activate():
	active = true
	$Indicator/Label.text = "ON"
	$Indicator.modulate = Color("#ffffff")
	$Texture.modulate = Color("#aaffffff")
	for body in $Area2D.get_overlapping_bodies():
		body.external_force = Vector2(0,-100)
		
func deactivate():
	active = false
	$Indicator/Label.text = "OFF"
	$Indicator.modulate = Color("#5e5e5e")
	$Texture.modulate = Color("#49ffffff")
	for body in $Area2D.get_overlapping_bodies():
		body.external_force = Vector2(0,0)

func _on_Trigger_body_entered(body):
	activate()
	
func _on_Trigger_body_exited(body):
	deactivate()

func _on_Area2D_body_entered(body):
	if active:
	  body.external_force = Vector2(0, -100)
	
func _on_Area2D_body_exited(body):
	if active:
	  body.external_force = Vector2(0,0)