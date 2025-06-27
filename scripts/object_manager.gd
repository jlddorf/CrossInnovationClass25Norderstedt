extends Node

const CustomTypes = preload("res://scripts/custom_types.gd")
const OBJECT : PackedScene = preload("res://scenes/object.tscn")

var placed_items: Dictionary[CustomTypes.Item, Array]
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _on_player_manager_update_player_item(_player_id: int, item: int, new_amount: int) -> void:
	var itemList: Array = placed_items.get_or_add(item, Array()) as Array
	var item_difference: int = new_amount - itemList.size()
	# If item difference is greater than 0, place items to balance it out
	while item_difference > 0:
		var node : Node3D = OBJECT.instantiate()
		self.add_child(node)
		node.position = Vector3(rng.randf_range(-2.0, 2.0), 0.25, rng.randf_range(-2.0, 2.0))
		item_difference -= 1
		placed_items[item].append(node)
	# If item difference is less than 0, remove items to balance it out
	while item_difference < 0:
		var last_item: Node3D = itemList.pop_back() as Node3D
		last_item.queue_free()
		item_difference += 1
		
		
		
