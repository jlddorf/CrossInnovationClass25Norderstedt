@tool
extends Node
class_name AchievementRect

@export var achievementTexture : Texture2D
@onready var _achievement_texture: AchievementTexture = $AchievementTexture

const Constants = preload("res://scripts/constants.gd")

var currentPoints: int = 0

func _ready() -> void:
	_achievement_texture.texture = achievementTexture

# Update the achievements point value
func update_achievement(change: int) -> void: 
	var temp: int = currentPoints
	currentPoints += change
	if (temp < Constants.ACHIEVEMENT_THRESHOLD && currentPoints >= Constants.ACHIEVEMENT_THRESHOLD):
		print("updating achievement")
		_achievement_texture.mark_granted()
