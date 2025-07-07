extends Control

const CustomTypes = preload("res://scripts/custom_types.gd")

@onready var limit_counter: Label = %LimitCounter
@onready var achievement_climate: AchievementRect = %AchievementClimate
@onready var achievement_health: AchievementRect = %AchievementHealth
@onready var achievement_green: AchievementRect = %AchievementGreen
@onready var achievement_integration: AchievementRect = %AchievementIntegration
@onready var achievement_short_ways: AchievementRect = %AchievementShortWays
@onready var achievement_circular: AchievementRect = %AchievementCircular
@onready var achievement_fairtrade: AchievementRect = %AchievementFairtrade

var all_containers : Array[Node]
@onready var coin_icon: TextureRect = %CoinIcon

func _ready() -> void:
	all_containers = get_tree().get_nodes_in_group("PlayerContainer")
	limit_counter.text = str(Constants.ACHIEVEMENT_THRESHOLD)
	

func _on_player_manager_update_player_item(player_id: int, item: int, currentAmount: int, change: int) -> void:
	var player_container : Array[Node] = all_containers.filter(func(container: PlayerContainer) -> bool: return container.player_id == player_id)
	for node: PlayerContainer in player_container:
		node.update_item_display(item, currentAmount)
	limit_counter.text = str(Constants.ACHIEVEMENT_THRESHOLD - currentAmount)
	var counter_position: Vector2 = coin_icon.global_position + coin_icon.size / 2
	match item:
		CustomTypes.Item.NATURE:
			achievement_climate.update_achievement(change, counter_position)
			achievement_green.update_achievement(change, counter_position)
		CustomTypes.Item.MOBILITY:
			achievement_health.update_achievement(change, counter_position)
			achievement_short_ways.update_achievement(change, counter_position)
		CustomTypes.Item.ENERGY_BUILDING:
			achievement_climate.update_achievement(change, counter_position)
		CustomTypes.Item.COMMUNITY:
			achievement_integration.update_achievement(change, counter_position)
		CustomTypes.Item.CIRCULAR_ECONOMY:
			achievement_circular.update_achievement(change, counter_position)
			achievement_fairtrade.update_achievement(change, counter_position)
		CustomTypes.Item.LOCAL_CONSUMPTION:
			achievement_climate.update_achievement(change, counter_position)
			achievement_fairtrade.update_achievement(change, counter_position)
