extends ProgressBar
class_name AmountProgress

const CustomTypes = preload("res://scripts/custom_types.gd")

func _ready() -> void:
	max_value = CustomTypes.MAX_AMOUNT_OF_ONE_ITEM

func changeValue(target: float) -> void:
	self.value = target

func makeIndeterminable(enabled: bool) -> void:
	self.indeterminate = enabled
