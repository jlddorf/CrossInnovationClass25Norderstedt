extends Node
class_name PlayerManager

const CustomTypes = preload("res://scripts/custom_types.gd")

signal update_player_item(player_id: int, item: CustomTypes.Item, currentAmount: int, change: int)

signal button_press_registered(player_id: int)

# Dictionary of the player id to the selected item
static var selected_items : Dictionary[int, CustomTypes.Item]

# Dictionary of every item and it's respective placement amount. If this includes NONE, something has gone very wrong 
static var item_amounts: Dictionary[CustomTypes.Item, int]

# Amount of placed items
static var item_count : int = 0

func _ready() -> void:
	var socket_manager : Array[Node] = get_tree().get_nodes_in_group("SocketManager")
	# Connects to all sockets that receive input
	for node : Node in socket_manager:
		node.connect("encoder_changed", change_selected_amount_of_player)
		node.connect("item_changed", change_item_of_player)
		node.connect("button_pressed", register_button_press)
		
func emit_item_update(player_id: int, change: int) -> void:
	var current_item : CustomTypes.Item = selected_items.get(player_id, CustomTypes.Item.NONE)
	update_player_item.emit(player_id, current_item, item_count, change)
		
func change_selected_amount_of_player(player_id: int, change: int) -> void:
	if player_id > 0 && player_id <= CustomTypes.PLAYER_COUNT:
		var player_item : CustomTypes.Item = selected_items.get_or_add(player_id, CustomTypes.Item.NONE)
		if (player_item != CustomTypes.Item.NONE):
			# Cap change between available items of type and items left
			change = clamp(change, -item_amounts.get_or_add(player_item, 0), CustomTypes.MAX_AMOUNT_OF_ONE_ITEM - item_count)
			item_count += change
			# Clamp item progress of selected item between 0 and max item amount
			item_amounts[player_item] = clamp(item_amounts[player_item] + change, 0, CustomTypes.MAX_AMOUNT_OF_ONE_ITEM)
			emit_item_update(player_id, change)

func change_item_of_player(player_id: int, item: CustomTypes.Item) -> void:
	if player_id > 0 && player_id <= CustomTypes.PLAYER_COUNT: 
		selected_items[player_id] = item
		emit_item_update(player_id, 0)
			
func register_button_press(player_id: int) -> void:
	button_press_registered.emit(player_id)
	
func reset() -> void:
	item_count = 0
	for item: CustomTypes.Item in item_amounts:
		item_amounts[item] = 0
	
	
