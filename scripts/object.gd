extends MeshInstance3D
class_name MapObject

func _ready() -> void:
	var tween : Tween = self.create_tween()
	self.scale = Vector3(0.5, 0.5, 0.5)
	tween.tween_property(self, "scale", Vector3(1.3, 1.3, 1.3), 0.5)
	tween.tween_property(self, "scale", Vector3(1.0, 1.0, 1.0), 0.1)

func remove() -> void:
	var tween : Tween = self.create_tween()
	tween.set_ease(Tween.EASE_IN).tween_property(self, "scale", Vector3(0.1, 0.1, 0.1), 0.2)
	tween.tween_callback(self.queue_free)
