extends PanelContainer
@export var texture: Texture2D
@onready var texture_button: TextureButton = $TextureButton
@onready var icon_indicator: PanelContainer = $"."

func _ready() -> void:
	texture_button.texture_normal = texture



func _on_texture_button_toggled(toggled_on: bool) -> void:
	print("Button is %s" % str(toggled_on))
