extends CharacterBody2D

var og_pos: Vector2
func _ready() -> void:
	og_pos = position
	
func _process(delta: float) -> void:
	position = og_pos

@export var spr_comp : change_sprite_comp

func do_destroy() -> void:
	spr_comp.change_sprite()

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	move_and_slide()
	velocity = Vector2.ZERO
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_angle() == 0:
			do_destroy() 
			collision.get_collider().velocity.y = 0
