extends MeshInstance3D
class_name MapObjectTexture

const CustomTypes = preload("res://scripts/custom_types.gd")

const CIRCULAR_ECONOMY_ICON: Texture2D = preload("res://assets/images/StationIcons/circularEconomyIcon.png")
const COMMUNITY_ICON: Texture2D = preload("res://assets/images/StationIcons/communityIcon.png")
const ENERGY_BUILDING_ICON: Texture2D = preload("res://assets/images/StationIcons/energyBuildingIcon.png")
const LOCAL_CONSUMPTION_ICON: Texture2D = preload("res://assets/images/StationIcons/localConsumptionIcon.png")
const MOBILITY_ICON: Texture2D = preload("res://assets/images/StationIcons/mobilityIcon.png")
const NATURE_ICON: Texture2D = preload("res://assets/images/StationIcons/natureIcon.png")

func _ready() -> void:
	var tween : Tween = self.create_tween()
	self.scale = Vector3(0.5, 0.5, 0.5)
	tween.tween_property(self, "scale", Vector3(1.3, 1.3, 1.3), 0.5)
	tween.tween_property(self, "scale", Vector3(1.0, 1.0, 1.0), 0.1)

func set_item(item: CustomTypes.Item) -> void: 
	var material: StandardMaterial3D = mesh.surface_get_material(0)
	var objectMesh : PlaneMesh = mesh
	match item:
		CustomTypes.Item.NATURE:
			material.albedo_texture = NATURE_ICON
			objectMesh.size.x = NATURE_ICON.get_size().aspect()
		CustomTypes.Item.MOBILITY:
			material.albedo_texture = MOBILITY_ICON
			objectMesh.size.x = NATURE_ICON.get_size().aspect()
		CustomTypes.Item.ENERGY_BUILDING:
			material.albedo_texture = ENERGY_BUILDING_ICON
			objectMesh.size.x = NATURE_ICON.get_size().aspect()
		CustomTypes.Item.COMMUNITY:
			material.albedo_texture = COMMUNITY_ICON
			objectMesh.size.x = NATURE_ICON.get_size().aspect()
		CustomTypes.Item.CIRCULAR_ECONOMY:
			material.albedo_texture = CIRCULAR_ECONOMY_ICON
			objectMesh.size.x = NATURE_ICON.get_size().aspect()
		CustomTypes.Item.LOCAL_CONSUMPTION:
			material.albedo_texture = LOCAL_CONSUMPTION_ICON
			objectMesh.size.x = NATURE_ICON.get_size().aspect()
		_:
			print("Can't display unknown item %d" % item)
