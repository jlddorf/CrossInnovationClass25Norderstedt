extends TextureButton
class_name ItemDisplay

const QUESTION_MARK_SKETCH : Texture2D = preload("res://assets/images/Question Mark Sketch.png")
const CIRCULAR_ECONOMY_ICON : Texture2D = preload("res://assets/images/StationIcons/circularEconomyIcon.png")
const COMMUNITY_ICON : Texture2D = preload("res://assets/images/StationIcons/communityIcon.png")
const ENERGY_BUILDING_ICON : Texture2D = preload("res://assets/images/StationIcons/energyBuildingIcon.png")
const LOCAL_CONSUMPTION_ICON : Texture2D = preload("res://assets/images/StationIcons/localConsumptionIcon.png")
const MOBILITY_ICON : Texture2D = preload("res://assets/images/StationIcons/mobilityIcon.png")
const NATURE_ICON : Texture2D = preload("res://assets/images/StationIcons/natureIcon.png")

const CustomTypes = preload("res://scripts/custom_types.gd")

var currentTween : Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pivot_offset = self.size/2
	showNoItemPlaced()

func showItemPlaced(item: CustomTypes.Item) -> void:
	print("Switching to item" + str(item))
	if (currentTween != null):
		currentTween.kill()
	match item:
		CustomTypes.Item.NATURE:
			self.texture_normal = NATURE_ICON
		CustomTypes.Item.MOBILITY:
			self.texture_normal = MOBILITY_ICON
		CustomTypes.Item.ENERGY_BUILDING:
			self.texture_normal = ENERGY_BUILDING_ICON
		CustomTypes.Item.COMMUNITY:
			self.texture_normal = COMMUNITY_ICON
		CustomTypes.Item.CIRCULAR_ECONOMY:
			self.texture_normal = CIRCULAR_ECONOMY_ICON
		CustomTypes.Item.LOCAL_CONSUMPTION:
			self.texture_normal = LOCAL_CONSUMPTION_ICON
		_:
			print("Can't player station to item %d" % item)
	self.rotation_degrees = 0
	self.scale = Vector2(1.7, 1.7)
	currentTween = self.create_tween().set_parallel(true)
	currentTween.tween_property(self, "scale", Vector2(1, 1), 0.3).set_ease(Tween.EASE_IN)

func showNoItemPlaced() -> void:
	print("Switching to no item")
	if (currentTween != null):
		currentTween.kill()
	self.texture_normal = QUESTION_MARK_SKETCH
	currentTween = self.create_tween().set_parallel(true).set_loops(0)
	currentTween.tween_property(self, "rotation_degrees", 360, 5).from(0)
	currentTween.tween_property(self, "scale", Vector2(0.8, 0.8), 2.5)
	currentTween.chain().tween_property(self, "rotation_degrees", 360, 5).from(0)
	currentTween.tween_property(self, "scale", Vector2(1, 1), 2.5)
