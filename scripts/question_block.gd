extends AnimatableBody2D

@onready var hittable_comp: Area2D = $HittableComp

@export var spr_comp : change_sprite_comp

func do_destroy() -> void:
	spr_comp.change_sprite()
	hittable_comp.queue_free()


func _on_hittable_comp_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body.velocity:
		if body.velocity.y < 0:
			do_destroy() 
			body.velocity.y = 0
