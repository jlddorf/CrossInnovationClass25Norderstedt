extends TextureRect
class_name GrantedTexture

func _ready() -> void:
	pivot_offset = size / 2
	var tween : Tween = self.create_tween().set_loops()
	tween.tween_property(self, "rotation_degrees", 360, 5).from_current()
	
func hide_animated() -> void:
	var tween : Tween = self.create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 1)

func show_animated() -> void:
	var tween : Tween = self.create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,1), 1)
