extends CharacterBody2D

@export_group("Components")

@export_group("Settings")
@export var JUMP_VELOCITY: float = 500
@export var SPEED: float = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	
	if Input.is_action_pressed("move_jump") && is_on_floor():
		velocity.y = -JUMP_VELOCITY
	
	velocity.x = SPEED * Input.get_axis("move_right", "move_left")
	
	move_and_slide()
