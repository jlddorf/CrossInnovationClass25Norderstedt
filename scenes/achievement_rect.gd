extends TextureRect

@export var achievementTexture : Texture2D

var achievementTween: Tween

func _ready() -> void:
	self.texture = achievementTexture
	achievementTween = self.create_tween().set_loops(0)
	var viewportCenter = get_viewport_rect().get_center()
	achievementTween.tween_property(self, "position", viewportCenter, 5)
