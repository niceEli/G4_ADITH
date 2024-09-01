extends Node2D

@export var p: Player
@export var dash_speed: float = 1000

func _on_player_state_dash_physics_process(delta: float, dash_dir: Vector2, time_left: float) -> void:
	p.velocity = dash_dir * dash_speed
	p.move_and_slide()
