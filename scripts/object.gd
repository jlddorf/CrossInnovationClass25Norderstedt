extends MeshInstance3D

func _ready() -> void:
	var tween : Tween = self.create_tween()
	self.scale = Vector3(0.5, 0.5, 0.5)
	tween.tween_property(self, "scale", Vector3(1.3, 1.3, 1.3), 0.5)
	tween.tween_property(self, "scale", Vector3(1.0, 1.0, 1.0), 0.1)
