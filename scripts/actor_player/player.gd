extends CharacterBody2D

class_name Player

@onready var dash_timer: Timer = $DashTimer
@onready var just_dashed_timer: Timer = $JustDashedTimer
@onready var dash_particles: GPUParticles2D = $DashParticles

var state: String = ""

var dashes: int = 0

var dash_time: float = 0.02
var just_dash_time: float = 0.1
@export var max_dashes: int = 1
var dash_dir: Vector2

var just_finished: int = 0

signal state_default_physics_process(delta: float, just_dashed: bool)

signal state_dash_physics_process(delta: float, dash_dir: Vector2, time_left: float)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_on_floor():
		dashes = max_dashes
		
	if Input.is_action_just_pressed("move_dash") and dashes > 0 and dash_timer.is_stopped():
		dash_dir = Input.get_vector("move_right", "move_left", "move_up", "move_down")
		if is_on_floor():
			dash_dir = Vector2(Input.get_axis("move_right", "move_left"),0)
		
		if dash_dir != Vector2.ZERO:
			state = "dash"
			dashes -= 1
			dash_timer.start(dash_time)
			just_dashed_timer.start(just_dash_time)
			just_finished = 1
		
	if is_on_floor():
		just_dashed_timer.stop()
		
	if dash_timer.is_stopped():
		state = ""
	
	if just_dashed_timer.is_stopped():
		if just_finished == 1:
			just_finished = 2
		elif just_finished == 2:
			just_finished = 0
			
	if just_finished == 2 and velocity.y < 0:
		velocity.y = velocity.y / 2
	
	dash_particles.emitting = not just_dashed_timer.is_stopped()
	
	match state:
		"dash":
			state_dash_physics_process.emit(delta, dash_dir, dash_timer.time_left)
		_:
			state_default_physics_process.emit(delta, not just_dashed_timer.is_stopped())
