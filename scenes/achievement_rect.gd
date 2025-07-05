extends TextureRect
class_name AchievementTexture

var achievementTween: Tween

func _ready() -> void:
	pivot_offset = size / 2

func mark_granted() -> void:
	achievementTween = self.create_tween()
	var viewport_center : Vector2 = get_viewport_rect().get_center()
	var initial_position: Vector2 = global_position 
	achievementTween.tween_property(self, "global_position", viewport_center, 0.5).from(global_position)
	achievementTween.set_ease(Tween.EASE_IN_OUT).tween_property(self, "scale", Vector2(3,3), 0.3)
	achievementTween.set_ease(Tween.EASE_IN_OUT).tween_property(self, "scale", Vector2(1,1), 0.3)
	achievementTween.tween_property(self, "global_position", initial_position, 0.5).from(viewport_center)
