extends TextureRect
class_name AchievementTexture

var achievementTween: Tween

func mark_granted() -> void:
	achievementTween = self.create_tween().set_loops(0)
	var viewportCenter : Vector2 = get_viewport_rect().get_center()
	var distanceToMove: Vector2 = viewportCenter - global_position
	achievementTween.tween_property(self, "position", distanceToMove, 5)
