@tool
extends NinePatchRect

@onready var label: RichTextLabel = $HBoxContainer/RichTextLabel
@onready var fun_fact: Control = $".."
@onready var texture_rect: TextureRect = $HBoxContainer/TextureRect
@onready var h_box_container: HBoxContainer = $HBoxContainer

func _ready() -> void:
	label.custom_minimum_size.x = custom_minimum_size.x - patch_margin_left - patch_margin_right - texture_rect.custom_minimum_size.x
	fun_fact.custom_minimum_size = custom_minimum_size
	fun_fact.pivot_offset = size / 2

func _on_rich_text_label_resized() -> void:
	if h_box_container != null:
		custom_minimum_size = Vector2(h_box_container.size.x + patch_margin_left + patch_margin_right, h_box_container.size.y + patch_margin_bottom + patch_margin_top)
		fun_fact.custom_minimum_size = custom_minimum_size
