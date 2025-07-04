extends Control

const CustomTypes = preload("res://scripts/custom_types.gd")

@onready var achievement_climate: AchievementRect = %AchievementClimate
@onready var achievement_health: AchievementRect = %AchievementHealth
@onready var achievement_green: AchievementRect = %AchievementGreen
@onready var achievement_integration: AchievementRect = %AchievementIntegration
@onready var achievement_short_ways: AchievementRect = %AchievementShortWays
@onready var achievement_circular: AchievementRect = %AchievementCircular
@onready var achievement_fairtrade: AchievementRect = %AchievementFairtrade

var all_containers : Array[Node]

func _ready() -> void:
	all_containers = get_tree().get_nodes_in_group("PlayerContainer")
	

func _on_player_manager_update_player_item(player_id: int, item: int, currentAmount: int, change: int) -> void:
	var player_container : Array[Node] = all_containers.filter(func(container: PlayerContainer) -> bool: return container.player_id == player_id)
	for node: PlayerContainer in player_container:
		node.update_item_display(item, currentAmount)
	match item:
		CustomTypes.Item.NATURE:
			achievement_climate.update_achievement(change)
			achievement_green.update_achievement(change)

	
	
		
