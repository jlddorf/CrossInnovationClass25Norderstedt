extends Control
class_name UiManager

const CustomTypes = preload("res://scripts/custom_types.gd")

@onready var limit_counter: Label = %LimitCounter
@onready var achievement_climate: AchievementRect = %AchievementClimate
@onready var achievement_health: AchievementRect = %AchievementHealth
@onready var achievement_green: AchievementRect = %AchievementGreen
@onready var achievement_integration: AchievementRect = %AchievementIntegration
@onready var achievement_short_ways: AchievementRect = %AchievementShortWays
@onready var achievement_circular: AchievementRect = %AchievementCircular
@onready var achievement_fairtrade: AchievementRect = %AchievementFairtrade
@onready var fun_fact: FunFact = %FunFact

var all_containers : Array[Node]
@onready var coin_icon: TextureRect = %CoinIcon
var goal_progress: Dictionary[CustomTypes.Goals, int] = {
	CustomTypes.Goals.CLIMATE_PROTECTION: 0,
	CustomTypes.Goals.MATERIAL_CYCLES: 0,
	CustomTypes.Goals.HEALTHY_CITY: 0,
	CustomTypes.Goals.GREEN_CITY: 0,
	CustomTypes.Goals.FAIRTRADE: 0,
	CustomTypes.Goals.SOCIAL_INTEGRATION: 0,
	CustomTypes.Goals.SHORT_WAYS: 0,
}

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
			goal_progress[CustomTypes.Goals.CLIMATE_PROTECTION] += change * 2
			goal_progress[CustomTypes.Goals.GREEN_CITY] += change * 3
			achievement_climate.update_achievement(change * 2, counter_position)
			achievement_green.update_achievement(change * 3, counter_position)
		CustomTypes.Item.MOBILITY:
			goal_progress[CustomTypes.Goals.HEALTHY_CITY] += change * 2
			goal_progress[CustomTypes.Goals.SHORT_WAYS] += change * 3
			achievement_health.update_achievement(change * 2, counter_position)
			achievement_short_ways.update_achievement(change * 3, counter_position)
		CustomTypes.Item.ENERGY_BUILDING:
			goal_progress[CustomTypes.Goals.CLIMATE_PROTECTION] += change * 5
			achievement_climate.update_achievement(change * 5, counter_position)
		CustomTypes.Item.COMMUNITY:
			goal_progress[CustomTypes.Goals.SOCIAL_INTEGRATION] += change * 5
			achievement_integration.update_achievement(change * 5, counter_position)
		CustomTypes.Item.CIRCULAR_ECONOMY:
			goal_progress[CustomTypes.Goals.MATERIAL_CYCLES] += change * 3
			goal_progress[CustomTypes.Goals.FAIRTRADE] += change * 2
			achievement_circular.update_achievement(change * 3, counter_position)
			achievement_fairtrade.update_achievement(change * 2, counter_position)
		CustomTypes.Item.LOCAL_CONSUMPTION:
			goal_progress[CustomTypes.Goals.CLIMATE_PROTECTION] += change * 2
			goal_progress[CustomTypes.Goals.FAIRTRADE] += change * 3
			achievement_climate.update_achievement(change * 2, counter_position)
			achievement_fairtrade.update_achievement(change * 3, counter_position)


func _on_fun_fact_set_new_popup() -> void:
	var random: int = randi_range(0,10)
	var item: CustomTypes.Goals
	var elements : Array[int] = goal_progress.values()
	elements.sort()
	if random % 2 == 0:
		item = goal_progress.find_key(elements[elements.size() - 1])
	elif random % 3 == 0:
		item = goal_progress.find_key(elements[elements.size() - 2])
	else:
		item = goal_progress.keys()[randi() % goal_progress.size()]
	fun_fact.set_new_fact(item)
