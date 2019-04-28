extends Node2D

export var active = false

onready var area = $Texture/Area2D

func _ready():
	if active:
		activate()

func activate():
	active = true
	$Indicator/Label.text = "ON"
	$Indicator.modulate = Color("#ffffff")
	$Texture.modulate = Color("#aaffffff")
	for body in area.get_overlapping_bodies():
		if body.is_in_group("Elevatable"):
			body.external_force = Vector2(0,-100)
		
func deactivate():
	active = false
	$Indicator/Label.text = "OFF"
	$Indicator.modulate = Color("#5e5e5e")
	$Texture.modulate = Color("#49ffffff")
	for body in area.get_overlapping_bodies():
		if body.is_in_group("Elevatable"):
			body.external_force = Vector2(0,0)

func _on_Trigger_body_entered(body):
	activate()
	
func _on_Trigger_body_exited(body):
	deactivate()

func _on_Area2D_body_entered(body):
	print("BODY ENTERED")
	if active:
	  body.external_force = Vector2(0, -100)
	
func _on_Area2D_body_exited(body):
	print("BODY EXITED")
	if active:
	  body.external_force = Vector2(0,0)