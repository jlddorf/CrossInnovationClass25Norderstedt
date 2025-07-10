extends Node3D

@onready var socket_manager: SocketManager = $SocketManager/socket_manager
@onready var socket_manager_2: SocketManager = $SocketManager/socket_manager2
@onready var start_popup: Control = %StartPopup
@onready var ui_manager: UiManager = %UI_manager
@onready var game_timer: Timer = %GameTimer
@onready var button_timer: Timer = %ButtonTimer
@onready var end_screen_timer: Timer = %EndScreenTimer
@onready var end_popup: EndPopup = %EndPopup
@onready var player_manager: PlayerManager = $PlayerManager
@onready var object_manager: ObjectManager = $ObjectManager

var game_state : CustomTypes.GameState = CustomTypes.GameState.START
var button_already_pressed_by: int = -1

func _ready() -> void:
	get_tree().set_auto_accept_quit(false)
	ui_manager.modulate = Color(1,1,1,0)
	end_popup.modulate = Color(1,1,1,0)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("got close request")
		socket_manager.cleanup()
		socket_manager_2.cleanup()
		get_tree().quit() # default behavior

func start_game() -> void:
	print("Starting end screen")
	var tween : Tween = self.create_tween()
	tween.tween_property(start_popup, "modulate", Color(1,1,1,0), 1)
	tween.tween_property(ui_manager, "modulate", Color(1,1,1,1), 1)
	game_timer.start()
	game_state = CustomTypes.GameState.RUNNING
	
	
func reset_game()-> void:
	print("Resetting game")
	var tween : Tween = self.create_tween()
	tween.tween_property(end_popup, "modulate", Color(1,1,1,0), 1)
	tween.tween_property(start_popup, "modulate", Color(1,1,1,1), 1)
	player_manager.reset()
	ui_manager.reset()
	object_manager.reset()
	game_state = CustomTypes.GameState.START


func show_end_screen() -> void:
	print("Showing end screen")
	game_timer.stop()
	end_screen_timer.start()
	game_state = CustomTypes.GameState.END
	var goals : Array = ui_manager.goal_progress.values()
	var categories: Dictionary[CustomTypes.Goals, int] = ui_manager.goal_progress.duplicate()
	goals.sort()
	var goal1: CustomTypes.Goals = categories.find_key(goals[goals.size() - 1])
	categories.erase(goal1)
	var goal2: CustomTypes.Goals = categories.find_key(goals[goals.size() - 2])
	categories.erase(goal2)
	var goal3: CustomTypes.Goals = categories.find_key(goals[goals.size() - 3])
	end_popup.change_goals(goal1, goal2, goal3)
	var tween : Tween = self.create_tween()
	tween.tween_property(ui_manager, "modulate", Color(1,1,1,0), 1)
	tween.tween_property(end_popup, "modulate", Color(1,1,1,1), 1)

	
	
func _on_player_manager_button_press_registered(player_id: int) -> void:
	match game_state:
		CustomTypes.GameState.START:
			start_game()
		CustomTypes.GameState.RUNNING:
			if (button_timer.time_left > 0 && button_already_pressed_by != player_id):
				show_end_screen()
			else:
				button_already_pressed_by = player_id
				button_timer.start()


func _on_end_screen_timer_timeout() -> void:
	reset_game()



func _on_player_manager_update_player_item(_player_id: int, _item: int, _currentAmount: int, _change: int) -> void:
	if game_state == CustomTypes.GameState.RUNNING:
		game_timer.start()


func _on_game_timer_timeout() -> void:
	show_end_screen()
