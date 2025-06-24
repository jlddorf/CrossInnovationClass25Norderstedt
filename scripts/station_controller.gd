extends Node

@export var player_id : int
@export var playerContainer: PlayerContainer

const GlobalValues = preload("res://scripts/globalValues.gd")

# The previous item to only change display when item changes
var deltaItem: GlobalValues.Item = GlobalValues.Item.NONE
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Not statically typed because of scenario when player doesn't have an assigned value yet
	var selectedItem = GlobalValues.selectedItems.get(player_id)
	if (selectedItem != null && selectedItem != deltaItem):
		match selectedItem:
			GlobalValues.Item.NATURE:
				playerContainer.showItemPlaced(GlobalValues.Item.NATURE)
				playerContainer.makeIndeterminable(false)
			GlobalValues.Item.NONE:
				playerContainer.showNoItemPlaced()
				playerContainer.changeValue(0)
				playerContainer.makeIndeterminable(true)
		deltaItem = selectedItem
	if (selectedItem != null && selectedItem != GlobalValues.Item.NONE):
		var value = GlobalValues.selectedProgress.get(selectedItem)
		if (value != null):
			playerContainer.changeValue(value) 
		else:
			playerContainer.changeValue(0)
