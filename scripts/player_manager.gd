extends Node

const CustomTypes = preload("res://scripts/custom_types.gd")

signal update_player_item(player_id: int, item: CustomTypes.Item, currentAmount: int)

# Dictionary of the player id to the selected item
static var selected_items : Dictionary[int, CustomTypes.Item]

# Dictionary of every item and it's respective placement amount. If this includes NONE, something has gone very wrong 
static var item_progress: Dictionary[CustomTypes.Item, int]

func _ready() -> void:
	var socket_manager : Array[Node] = get_tree().get_nodes_in_group("SocketManager")
	# Connects to all sockets that receive input
	for node : Node in socket_manager:
		node.connect("encoder_changed", change_selected_amount_of_player)
		node.connect("item_changed", change_item_of_player)
		
func emit_item_update(player_id: int) -> void:
	var current_item : CustomTypes.Item = selected_items.get(player_id, CustomTypes.Item.NONE)
	var current_amount : int = item_progress.get(current_item, 0)
	update_player_item.emit(player_id, current_item, current_amount)
		
func change_selected_amount_of_player(player_id: int, change: int) -> void:
	if player_id > 0 && player_id <= CustomTypes.PLAYER_COUNT:
		var player_item : CustomTypes.Item = selected_items.get_or_add(player_id, CustomTypes.Item.NONE)
		if (player_item != CustomTypes.Item.NONE):
			var item_amount : int = item_progress.get_or_add(player_item, 0)
			item_progress[player_item] = clamp(item_amount + change, 0, 100)
			emit_item_update(player_id)

func change_item_of_player(player_id: int, item: CustomTypes.Item) -> void:
	if player_id > 0 && player_id <= CustomTypes.PLAYER_COUNT: 
		selected_items[player_id] = item
		emit_item_update(player_id)
			
	
