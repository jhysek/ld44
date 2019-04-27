extends KinematicBody2D

export var GRAVITY = 40 * 70 
export var SPEED   = 30000
export var JUMP_SPEED  = -900

var dead = false
var possessed = false
var in_air = false
var was_in_air = false
var jump_timeout = 0

var motion = Vector2(0,0)

func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	motion.y += GRAVITY * delta
	
	if possessed and not dead:
		controlled_process(delta)
	
	if dead:
		motion.x = lerp(motion.x, 0, 4 * delta)
			
	motion = move_and_slide(motion, Vector2(0, -1), 1, 4)
	
func possess():
	print("POSSESSED");
	possessed = true
	
func breakup():
	print("BREAKUP");
	possessed = false
	
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

	#if was_in_air and !in_air:
	#	$Sfx/Jump.play()
		
	was_in_air = in_air
	
	if !dead:
		if not in_air and Input.is_action_just_pressed("ui_up"):
			in_air = true
			#$RunParticles.emitting = false
			jump_timeout = 0
			#anim.play("Jump")
			#$Sfx/Jump0.play()
			motion.y = JUMP_SPEED
			#if sfx_run:
			#	sfx_run.stop()
	
		if Input.is_action_pressed('ui_right'):
			#if not in_air and anim.current_animation != "WalkRight":
            # anim.play("WalkRight")
			motion.x = min(motion.x + SPEED * delta, SPEED * delta)
			#sprite.scale.x = 1
			#if sfx_run and !sfx_run.playing and !in_air:
			#	 sfx_run.play()
			#	 $RunParticles.emitting = true
				
		if Input.is_action_pressed('ui_left'):
			#if not in_air and anim.current_animation != "WalkLeft":
			#	anim.play("WalkLeft")
			motion.x = max(motion.x - SPEED * delta, -SPEED * delta)
			#sprite.scale.x = -1
			
			#if sfx_run and !sfx_run.playing and !in_air:
			#	 sfx_run.play()
			#	 $RunParticles.emitting = true
			
		elif !Input.is_action_pressed('ui_right'):
			#if !in_air and anim.current_animation != idle_controlled_anim and fire_cooldown <= 0:
			#	anim.play(idle_controlled_anim)
			#	$RunParticles.emitting = false
				
			motion.x = 0
			#if sfx_run:
			#	sfx_run.stop()
				
		#if Input.is_action_pressed('ui_possess'):
		#	start_posessing()
		
	else:
		motion.x = 0
		
		#if !Input.is_action_pressed('ui_possess'):
		#	stop_posessing()

