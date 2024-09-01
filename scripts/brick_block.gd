extends CharacterBody2D

const particle = preload("res://scenes/actors/brick_break_particles.tscn")

var og_pos: Vector2
func _ready() -> void:
	og_pos = position
	
func _process(delta: float) -> void:
	position = og_pos

@export var br_comp: breakable_comp

func do_destroy() -> void:
	var p = particle.instantiate()
	p.position = position
	get_parent().add_child(p)
	br_comp.destroy()

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	move_and_slide()
	velocity = Vector2.ZERO
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_angle() == 0:
			do_destroy() 
			collision.get_collider().velocity.y = 0
