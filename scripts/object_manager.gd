extends Node

const CustomTypes = preload("res://scripts/custom_types.gd")
const OBJECT : PackedScene = preload("res://scenes/object.tscn")

@export var target_mesh: MeshInstance3D

var placed_items: Dictionary[CustomTypes.Item, Array]
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _on_player_manager_update_player_item(_player_id: int, item: CustomTypes.Item, _new_amount: int, changed: int) -> void:
	var itemList: Array = placed_items.get_or_add(item, Array()) as Array
	#var item_difference: int = new_amount - itemList.size()
	# If item difference is greater than 0, place items to balance it out
	while changed > 0:
		var node : MapObject = OBJECT.instantiate()
		node.item = item
		node.position = get_random_coordinate_on_mesh()
		self.add_child(node)
		changed -= 1
		placed_items[item].append(node)
	# If item difference is less than 0, remove items to balance it out
	while changed < 0:
		var last_item: MapObject = itemList.pop_back() as MapObject
		last_item.remove()
		changed += 1
		
func get_random_coordinate_on_mesh() -> Vector3:
	var viewport: Window = get_viewport()
	var viewport_size : Vector2 = viewport.size / 2
	var size : Vector3 = target_mesh.mesh.get_aabb().size.abs()
	var halfX : float = clamp(size.x / 2, -viewport_size.x, viewport_size.x)
	var halfZ : float = clamp(size.z / 2, -viewport_size.y, viewport_size.y)
	return Vector3(rng.randf_range(-halfX, halfX), 0.25, rng.randf_range(-halfZ, halfZ))
