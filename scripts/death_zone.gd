extends Node2D

var queue_dead: bool = false

func _process(_delta: float) -> void:
	if queue_dead:
		get_tree().reload_current_scene()

func _on_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	queue_dead = true
