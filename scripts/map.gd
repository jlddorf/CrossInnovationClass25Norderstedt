extends Node3D

@onready var socket_manager: SocketManager = $SocketManager/socket_manager
@onready var socket_manager_2: SocketManager = $SocketManager/socket_manager2

func _ready() -> void:
	get_tree().set_auto_accept_quit(false)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("got close request")
		socket_manager.cleanup()
		socket_manager_2.cleanup()
		get_tree().quit() # default behavior
