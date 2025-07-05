extends TextureRect
class_name AchievementTexture

var default_position : Vector2
var animationRunning : bool = false

func _ready() -> void:
	pivot_offset = size / 2
	

func mark_granted() -> void:
	if !animationRunning:
		animationRunning = true
		var viewport_center : Vector2 = get_viewport_rect().get_center()
		var achievementTween: Tween = self.create_tween()
		achievementTween.tween_property(self, "global_position", viewport_center, 0.5).from(default_position)
		achievementTween.set_ease(Tween.EASE_IN_OUT).tween_property(self, "scale", Vector2(3,3), 0.3)
		achievementTween.set_ease(Tween.EASE_IN_OUT).tween_property(self, "scale", Vector2(1,1), 0.3)
		achievementTween.tween_property(self, "global_position", default_position, 0.5).from(viewport_center)
		animationRunning = false
		
func _process(_delta: float) -> void:
	default_position = global_position
	if (default_position != Vector2(0,0)):
		set_process(false)
