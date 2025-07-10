@tool
extends Node
class_name AchievementRect

@export var achievementTexture : Texture2D
@onready var _achievement_texture: AchievementTexture = $AchievementTexture
@onready var coin_icon: TextureRect = %CoinIcon

const POINT_PARTICLE: PackedScene = preload("res://scenes/point_particle.tscn")

const Constants = preload("res://scripts/constants.gd")

@onready var add_point_player: AudioStreamPlayer = %AddPointPlayer
@onready var grant_achievement_player: AudioStreamPlayer = %GrantAchievementPlayer
@onready var take_point_player: AudioStreamPlayer = %TakePointPlayer
@onready var granted_texture: GrantedTexture = %GrantedTexture

var currentPoints: int = 0

func _ready() -> void:
	_achievement_texture.texture = achievementTexture

# Update the achievements point value
func update_achievement(change: int, counter_position: Vector2) -> void: 
	var node: Node2D = POINT_PARTICLE.instantiate()
	var tween: Tween = node.create_tween()

	if change > 0:
		node.global_position = counter_position
		self.add_child(node)
		tween.tween_property(node, "global_position", _achievement_texture.global_position + _achievement_texture.size / 2, 0.2).from(counter_position)
	elif change < 0:
		node.global_position = counter_position
		self.add_child(node)
		tween.tween_property(node, "global_position", counter_position, 0.2).from(_achievement_texture.global_position + _achievement_texture.size / 2)
	tween.tween_callback(update_achievement_value.bind(change))
	tween.tween_callback(node.queue_free)

		
func update_achievement_value(change: int) -> void:
	var temp: int = currentPoints
	currentPoints += change
	_achievement_texture.update_process(currentPoints as float / Constants.ACHIEVEMENT_THRESHOLD)
	if (temp < Constants.ACHIEVEMENT_THRESHOLD && currentPoints >= Constants.ACHIEVEMENT_THRESHOLD):
		print("updating achievement")
		grant_achievement_player.play()
		_achievement_texture.mark_granted()
		granted_texture.show_animated()
	elif (temp >= Constants.ACHIEVEMENT_THRESHOLD && currentPoints < Constants.ACHIEVEMENT_THRESHOLD):
		granted_texture.hide_animated()
	elif (change > 0):
		add_point_player.play()
	elif (change < 0):
		take_point_player.play()

		
