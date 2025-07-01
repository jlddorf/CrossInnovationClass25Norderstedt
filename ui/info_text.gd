extends RichTextLabel
class_name InfoText


const CustomTypes = preload("res://scripts/custom_types.gd")
const Constants = preload("res://scripts/constants.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_text_for_item(CustomTypes.Item.NONE)

func display_text_for_item(item: CustomTypes.Item) -> void:
	match item:
		CustomTypes.Item.NATURE:
			text = Constants.INFO_NATURE
		CustomTypes.Item.MOBILITY:
			text = Constants.INFO_MOBILITY
		CustomTypes.Item.ENERGY_BUILDING:
			text = Constants.INFO_ENERGY_BUILDING
		CustomTypes.Item.COMMUNITY:
			text = Constants.INFO_COMMUNITY
		CustomTypes.Item.CIRCULAR_ECONOMY:
			text = Constants.INFO_CIRCULAR_ECONOMY
		CustomTypes.Item.LOCAL_CONSUMPTION:
			text = Constants.INFO_LOCAL_CONSUMPTION
		CustomTypes.Item.NONE:
			text = Constants.INFO_NONE
		_:
			print("Can't change text for item %d" % item)
