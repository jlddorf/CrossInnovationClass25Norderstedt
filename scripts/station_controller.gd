extends Node

@export var player_id : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("select_icon_tree%d" % player_id):
		print("Player %d: Tree is selected" % player_id)
