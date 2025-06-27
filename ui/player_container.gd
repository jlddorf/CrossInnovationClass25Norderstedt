extends MarginContainer
class_name PlayerContainer

@export var player_id : int
@onready var placed_amount_bar: AmountProgress = %PlacedAmountBar
@onready var item_display : ItemDisplay = %ItemDisplay

const PlayerManager = preload("res://scripts/player_manager.gd")
const CustomTypes = preload("res://scripts/custom_types.gd")

# The previous item to only change display when item changes
var deltaItem: CustomTypes.Item = CustomTypes.Item.NONE

func update_item_display(item: CustomTypes.Item, amount: int) -> void:
	# Update item if necessary
	if item != deltaItem:
		if item != CustomTypes.Item.NONE:
			item_display.showItemPlaced(item)
			placed_amount_bar.makeIndeterminable(false)
		else:
			item_display.showNoItemPlaced()
			placed_amount_bar.makeIndeterminable(true)
		deltaItem = item
	# Update item values
	placed_amount_bar.changeValue(amount)
