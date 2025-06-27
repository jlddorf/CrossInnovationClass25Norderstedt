extends TextureButton
class_name ItemDisplay

const QUESTION_MARK_SKETCH : Texture2D = preload("res://assets/images/Question Mark Sketch.png")
const TREE_ICON : Texture2D = preload("res://assets/images/treeIcon.png")
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
			self.texture_normal = TREE_ICON
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
