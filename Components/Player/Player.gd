extends KinematicBody2D

export var GRAVITY = 70 * 70 
export var SPEED   = 40000
export var JUMP_SPEED  = -1400
export var dead = false

var in_air = false
var was_in_air = false
var possessing = false
var breaking_up = false
var jump_timeout = 0

var motion = Vector2(0,0)
var external_force = Vector2(0,0)

onready var breakup_ray = $BreakupRay
onready var influence_range = $InfluenceRange
onready var anim = $AnimationPlayer
onready var sprite = $Visual
onready var game = get_node("/root/Level")
onready var sfx_run = $Sfx/Run

func _ready():
  set_physics_process(true)


func _physics_process(delta):
	if game and game.paused:
		return
		
	motion.y += GRAVITY * delta
	
	if not dead:
		controlled_process(delta)
	
	if dead:
		motion.x = lerp(motion.x, 0, 4 * delta)
			
	motion = move_and_slide(motion + external_force, Vector2(0, -1), 1, 4)


func controlled_process(delta):
	var grounded = is_on_floor()
	if grounded:
		in_air = false
		jump_timeout = 0
		
	elif !in_air and jump_timeout <= 0:
		jump_timeout = 0.11
		
	if jump_timeout > 0:
		jump_timeout -= delta
		if jump_timeout <= 0:
			in_air = true

	if was_in_air and !in_air:
		$Sfx/Jump.play()
		
	was_in_air = in_air
	
	if !dead:
		if not in_air and Input.is_action_just_pressed("ui_up"):
			in_air = true
			#$RunParticles.emitting = false
			jump_timeout = 0
			if !breaking_up and !possessing:
			  anim.play("Jump")
			$Sfx/Jump.play()
			motion.y = JUMP_SPEED
			sfx_run.stop()
	
		if Input.is_action_pressed('ui_right'):
			if !breaking_up and !possessing and !in_air and anim.current_animation != "WalkRight":
			  anim.play("WalkRight")
			motion.x = min(motion.x + SPEED * delta, SPEED * delta)
			sprite.scale.x = 0.5
			if sfx_run and !sfx_run.playing and !in_air:
				sfx_run.play()
				
		if Input.is_action_pressed('ui_left'):
			if not breaking_up and not possessing and  not in_air and anim.current_animation != "WalkLeft":
			  anim.play("WalkLeft")
			motion.x = max(motion.x - SPEED * delta, -SPEED * delta)
			sprite.scale.x = -0.5
			if sfx_run and !sfx_run.playing and !in_air:
				 sfx_run.play()
			
		elif !Input.is_action_pressed('ui_right'):
			if not breaking_up and not possessing and !in_air and anim.current_animation != "Idle" and anim.current_animation != "Breakup" and not possessing:
				anim.play("Idle")
				
			motion.x = 0
			if sfx_run and sfx_run.playing:
				sfx_run.stop()
				
		if Input.is_action_just_pressed('ui_breakup'):
			anim.play("Breakup")
			breaking_up = true
			$BreakUpTimer.start()
			$Sfx.get_node("Breakup" + str(randi() % 2 + 1)).play()
				
		if !breaking_up and Input.is_action_just_pressed('ui_select'):
			anim.play("Possess")
			possessing = true
			$Sfx.get_node("Possess" + str(randi() % 2 + 1)).play()
			for body in influence_range.get_overlapping_bodies():
				if body.is_in_group("Possessable"):
					body.possess()
				
	else:
		motion.x = 0

func broke_up():
	breaking_up = false
	$Visual/Heart.modulate = Color(1,1,1,0)
	if breakup_ray.is_colliding():
		breakup_ray.get_collider().breakup()

func stop_possessing():
	possessing = false
	

func _on_BreakUpTimer_timeout():
	broke_up();
