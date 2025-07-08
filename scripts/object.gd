extends Node3D
class_name MapObject

@onready var object_holder: MapObjectTexture = %ObjectHolder

var item : CustomTypes.Item

func _ready() -> void:
	object_holder.set_item(item)

func remove() -> void:
	var tween : Tween = object_holder.create_tween()
	tween.set_ease(Tween.EASE_IN).tween_property(self, "scale", Vector3(0.1, 0.1, 0.1), 0.2)
	tween.tween_callback(self.queue_free)
	
