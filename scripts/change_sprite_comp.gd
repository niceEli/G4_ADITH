extends Node2D

class_name change_sprite_comp

@export var sprite: Texture2D

@export var sprite2DComp: Sprite2D

func change_sprite():
	sprite2DComp.texture = sprite
