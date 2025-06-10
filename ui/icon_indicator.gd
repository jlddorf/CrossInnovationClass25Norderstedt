extends PanelContainer
@export var texture: Texture2D
@onready var texture_button: TextureButton = $TextureButton
@onready var icon_indicator: PanelContainer = $"."

func _ready() -> void:
	texture_button.texture_normal = texture



func _on_texture_button_pressed() -> void:
	print("Button has been pressed")
