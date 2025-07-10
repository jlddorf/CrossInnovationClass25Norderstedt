extends Control
class_name FunFact

@onready var hide_popup_timer: Timer = $HidePopupTimer
@onready var rich_text_label: RichTextLabel = $NinePatchRect/HBoxContainer/RichTextLabel
@onready var texture_rect: TextureRect = $NinePatchRect/HBoxContainer/TextureRect

const CIRCULAR_ICON : Texture2D = preload("res://assets/images/GoalIcons/circularIcon.png")
const CLIMATE_PROTECTION_ICON : Texture2D = preload("res://assets/images/GoalIcons/climateProtectionIcon.png")
const FAIR_TRADE_ICON : Texture2D = preload("res://assets/images/GoalIcons/fairTradeIcon.png")
const GREEN_CITY_ICON : Texture2D = preload("res://assets/images/GoalIcons/greenCityIcon.png")
const HEALTHY_CITY_ICON : Texture2D = preload("res://assets/images/GoalIcons/healthyCityIcon.png")
const SHORT_WAYS_ICON : Texture2D = preload("res://assets/images/GoalIcons/shortWaysIcon.png")
const SOCIAL_INTEGRATION_ICON : Texture2D = preload("res://assets/images/GoalIcons/socialIntegrationIcon.png")
signal set_new_popup

var facts : Dictionary[CustomTypes.Goals, PackedStringArray] = Constants.FUN_FACTS

func _ready() -> void:
	modulate = Color(1,1,1,0)

func _on_timer_timeout() -> void:
	set_new_popup.emit()
	var tween : Tween = self.create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,1), 1)
	hide_popup_timer.start()
	

func _on_hide_popup_timer_timeout() -> void:
	var tween : Tween = self.create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 1)

func set_new_fact(goal: CustomTypes.Goals) -> void:
	var goal_array: PackedStringArray = facts.get(goal)
	var random_element: String = goal_array[randi() % goal_array.size()]
	rich_text_label.text = random_element
	match (goal):
		CustomTypes.Goals.CLIMATE_PROTECTION:
			texture_rect.texture = CLIMATE_PROTECTION_ICON
		CustomTypes.Goals.MATERIAL_CYCLES:
			texture_rect.texture = CIRCULAR_ICON
		CustomTypes.Goals.HEALTHY_CITY:
			texture_rect.texture = HEALTHY_CITY_ICON
		CustomTypes.Goals.GREEN_CITY:
			texture_rect.texture = GREEN_CITY_ICON
		CustomTypes.Goals.FAIRTRADE:
			texture_rect.texture = FAIR_TRADE_ICON
		CustomTypes.Goals.SOCIAL_INTEGRATION:
			texture_rect.texture = SOCIAL_INTEGRATION_ICON
		CustomTypes.Goals.SHORT_WAYS:
			texture_rect.texture = SHORT_WAYS_ICON



	
