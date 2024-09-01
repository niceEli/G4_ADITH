extends CharacterBody2D

@export_group("Components")

@export_group("Settings")
@export var JUMP_VELOCITY: float = 550
@export var SPEED: float = 50
@export var TERMINAL_SPEED: float = 500
@export var AIR_SPEED: float = 20
@export var TERMINAL_AIR_SPEED: float = 500
@export_range(0.00,1.00) var FRICTION: float = 0.8
@export_range(0.00,1.00) var AIR_FRICTION: float = 0.9

@export_range(0.00,1.00) var QUEUE_TIME: float = 0.16
@export_range(0.00,1.00) var COYOTE_TIME: float = 0.16

@export var sprite: Sprite2D

@export var flipdefault: bool = true

var can_jump: bool = false
var jq: float = 0
var ct: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	jq -= delta
	ct -= delta
	
	if jq <= 0:
		jq = 0
	if ct <= 0:
		ct = 0
	
	if Input.is_action_pressed("move_jump"):
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	else:
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * 3 * delta
	
	if is_on_floor():
		ct = COYOTE_TIME
	
	if Input.is_action_just_pressed("move_jump"):
		jq = QUEUE_TIME
		
	can_jump = (jq > 0) and (ct > 0)
	
	if can_jump:
		jq = 0
		ct = 0
		velocity.y = -JUMP_VELOCITY
	
	if is_on_floor():
		if (abs(Input.get_axis("move_right", "move_left")) < 0.1 or abs(velocity.x) > TERMINAL_SPEED): 
			velocity.x *= FRICTION
		velocity.x += SPEED * Input.get_axis("move_right", "move_left")
	else: 
		if (abs(Input.get_axis("move_right", "move_left")) < 0.1 or abs(velocity.x) > TERMINAL_AIR_SPEED): 
			velocity.x *= AIR_FRICTION
		velocity.x += AIR_SPEED * Input.get_axis("move_right", "move_left")
	
	if is_on_floor():
		if round(velocity.x) > 0:
			sprite.flip_h = flipdefault
		elif round(velocity.x) < 0:
			sprite.flip_h = not flipdefault
	
	move_and_slide()
