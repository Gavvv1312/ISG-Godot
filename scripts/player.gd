extends CharacterBody2D

@export var speed: float = 150.0

# 1. DEFINE STATES
enum State { IDLE, WALK }
var current_state = State.IDLE
var last_dir = "down"

@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer

func _physics_process(_delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	# 2. STATE TRANSITION LOGIC
	if input_dir != Vector2.ZERO:
		current_state = State.WALK
	else:
		current_state = State.IDLE
		
	# 3. EXECUTE STATE BEHAVIOR
	match current_state:
		State.IDLE:
			_handle_idle()
		State.WALK:
			_handle_walk(input_dir)

	# Apply actual physics movement
	velocity = input_dir * speed
	move_and_slide()

func _handle_walk(dir: Vector2) -> void:
	var anim_name = ""
	
	# Determine direction and animation row
	if abs(dir.x) > abs(dir.y):
		anim_name = "walk_side"
		sprite.flip_h = (dir.x > 0) # Flip if moving Right
		last_dir = "side"
	else:
		if dir.y > 0:
			anim_name = "walk_down"
			last_dir = "down"
		else:
			anim_name = "walk_up"
			last_dir = "up"
	
	# Only call play() if it's not already playing this specific animation
	if anim.current_animation != anim_name:
		anim.play(anim_name)

func _handle_idle() -> void:
	if anim.is_playing():
		anim.stop()
	
	# Set to neutral frame based on the last direction walked
	match last_dir:
		"down": sprite.frame = 0
		"up":   sprite.frame = 12
		"side": sprite.frame = 24
