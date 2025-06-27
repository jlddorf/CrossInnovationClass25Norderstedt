extends Control

var all_containers : Array[Node]

func _ready() -> void:
	all_containers = get_tree().get_nodes_in_group("PlayerContainer")
	

func _on_player_manager_update_player_item(player_id: int, item: int, currentAmount: int) -> void:
	var player_container : Array[Node] = all_containers.filter(func(container: PlayerContainer) -> bool: return container.player_id == player_id)
	for node: PlayerContainer in player_container:
		node.update_item_display(item, currentAmount)
