extends Node2D

class_name breakable_comp

func destroy() -> void:
	get_parent().queue_free()
