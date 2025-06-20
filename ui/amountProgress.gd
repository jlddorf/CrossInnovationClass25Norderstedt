extends ProgressBar
class_name AmountProgress

@export var player_id : int

const GlobalValues = preload("res://scripts/globalValues.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func changeValue(target: float):
	self.value = target
