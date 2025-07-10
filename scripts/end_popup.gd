extends Control
class_name EndPopup

@onready var goal_preference_1: TextureRect = %GoalPreference1
@onready var goal_preference_2: TextureRect = %GoalPreference2
@onready var goal_preference_3: TextureRect = %GoalPreference3
const CIRCULAR_GOAL: Texture2D = preload("res://assets/images/GoalGraphics/circular_goal.png")
const CLIMATE_GOAL: Texture2D = preload("res://assets/images/GoalGraphics/climate_goal.png")
const FAIRTRADE_GOAL: Texture2D = preload("res://assets/images/GoalGraphics/fairtrade_goal.png")
const GREEN_CITY_GOAL: Texture2D = preload("res://assets/images/GoalGraphics/green_city_goal.png")
const HEALTH_GOAL: Texture2D = preload("res://assets/images/GoalGraphics/health_goal.png")
const SHORT_WAYS_GOAL: Texture2D = preload("res://assets/images/GoalGraphics/short_ways_goal.png")
const SOCIAL_GOAL: Texture2D = preload("res://assets/images/GoalGraphics/social_goal.png")
@onready var begin_text: RichTextLabel = $Panel/MarginContainer/VBoxContainer/BeginText

func change_goals(goal1: CustomTypes.Goals, goal2: CustomTypes.Goals, goal3: CustomTypes.Goals, reached_goals: int) -> void:
	goal_preference_1.texture = get_texture_for_goal(goal1)
	goal_preference_2.texture = get_texture_for_goal(goal2)
	goal_preference_3.texture = get_texture_for_goal(goal3)
	if reached_goals != 0:
		begin_text.text = "Glückwunsch, ihr habt %d Ziele erreicht!
Es scheint, als wären euch dabei die folgenden Anliegen wichtig gewesen:" % reached_goals
	else:
		begin_text.text = "Scheinbar sind euch alle Ziele wichtig und keines hat euch vollständig vereinnahmt! Das ist gut, Balance ist wichtig!
Es scheint trotzdem aber, als wären euch dabei die folgenden Anliegen ein bisschen wichtiger gewesen:"


func get_texture_for_goal(goal: CustomTypes.Goals) -> Texture2D:
	var item: Texture2D
	match goal:
		CustomTypes.Goals.CLIMATE_PROTECTION:
			item = CLIMATE_GOAL
		CustomTypes.Goals.MATERIAL_CYCLES: 
			item = CIRCULAR_GOAL
		CustomTypes.Goals.HEALTHY_CITY: 
			item = HEALTH_GOAL
		CustomTypes.Goals.GREEN_CITY: 
			item = GREEN_CITY_GOAL
		CustomTypes.Goals.FAIRTRADE: 
			item = FAIRTRADE_GOAL
		CustomTypes.Goals.SOCIAL_INTEGRATION: 
			item = SOCIAL_GOAL
		CustomTypes.Goals.SHORT_WAYS:
			item = SHORT_WAYS_GOAL
	return item
		
