extends Node

const CustomTypes = preload("res://scripts/custom_types.gd")
const OBJECT : PackedScene = preload("res://scenes/object.tscn")

@export var target_mesh: MeshInstance3D

var placed_items: Dictionary[CustomTypes.Item, Array]
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var allowed_positions: Dictionary[CustomTypes.Item, PackedVector2Array]
var world_distance_per_pixel: Vector2
var upper_left_corner : Vector2
var target_mesh_size: Vector2

func _ready() -> void:
	allowed_positions[CustomTypes.Item.NATURE] = Constants.PLACEMENT_POINTS_NATURE
	allowed_positions[CustomTypes.Item.MOBILITY] = Constants.PLACEMENT_POINTS_STREETS
	allowed_positions[CustomTypes.Item.ENERGY_BUILDING] = Constants.PLACEABLE_POINTS_BUILDINGS
	var buildings_and_nature : PackedVector2Array = PackedVector2Array(Constants.PLACEABLE_POINTS_BUILDINGS)
	buildings_and_nature.append_array(Constants.PLACEMENT_POINTS_NATURE)
	allowed_positions[CustomTypes.Item.COMMUNITY] = buildings_and_nature
	allowed_positions[CustomTypes.Item.CIRCULAR_ECONOMY] = Constants.PLACEABLE_POINTS_BUILDINGS
	allowed_positions[CustomTypes.Item.LOCAL_CONSUMPTION] = Constants.PLACEABLE_POINTS_BUILDINGS
	var placement_mesh: PlaneMesh = target_mesh.mesh
	var target_mesh_material: StandardMaterial3D = placement_mesh.material
	target_mesh_size = placement_mesh.size
	world_distance_per_pixel = target_mesh_size / target_mesh_material.albedo_texture.get_size()
	upper_left_corner = Vector2(target_mesh.global_position.x, target_mesh.global_position.y) - placement_mesh.size / 2
	

func _on_player_manager_update_player_item(_player_id: int, item: CustomTypes.Item, _new_amount: int, changed: int) -> void:
	var itemList: Array = placed_items.get_or_add(item, Array()) as Array
	#var item_difference: int = new_amount - itemList.size()
	# If item difference is greater than 0, place items to balance it out
	while changed > 0:
		var node : MapObject = OBJECT.instantiate()
		node.item = item
		node.position = get_random_coordinate_on_mesh(item)
		self.add_child(node)
		changed -= 1
		placed_items[item].append(node)
	# If item difference is less than 0, remove items to balance it out
	while changed < 0:
		var last_item: MapObject = itemList.pop_back() as MapObject
		last_item.remove()
		changed += 1
		
func get_random_coordinate_on_mesh(item: CustomTypes.Item) -> Vector3:
	var item_array : PackedVector2Array = allowed_positions[item]
	var random_spot: Vector2 = item_array[randi() % item_array.size()]
	var spot_on_map: Vector2 = upper_left_corner + random_spot * world_distance_per_pixel
	# Set height dependent on height on image to avoid wrong drawing order
	var height : float = 0.05 * (spot_on_map.y / target_mesh_size.y)
	return Vector3(spot_on_map.x, 0.25 + height, spot_on_map.y)
