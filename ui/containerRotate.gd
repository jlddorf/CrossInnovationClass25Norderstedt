extends Control

func _ready() -> void:
	position = position + Vector2(-size.x, -size.y/2)
