extends MarginContainer
class_name PlayerContainer

const GlobalValues = preload("res://scripts/globalValues.gd")

@onready var placed_amount_bar: AmountProgress = $VBoxContainer/Panel/VBoxContainer/HBoxContainer/MarginContainer2/PlacedAmountBar
@onready var item_display: ItemDisplay = $VBoxContainer/Panel/VBoxContainer/HBoxContainer/MarginContainer/ItemDisplay

func changeValue(target: float):
	placed_amount_bar.changeValue(target)

func makeIndeterminable(enabled: bool):
	placed_amount_bar.makeIndeterminable(enabled)

func showItemPlaced(item: GlobalValues.Item):
	item_display.showItemPlaced(item)

func showNoItemPlaced():
	item_display.showNoItemPlaced()
