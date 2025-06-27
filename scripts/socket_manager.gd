extends Node
class_name SocketManager

@export var websocket_url : String
var socket: WebSocketPeer = WebSocketPeer.new()
@onready var json_parser: JSONParser = $JSON_parser

signal item_changed(player_id: int, new_item: int)
signal encoder_changed(player_id: int, change: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Starting input client on url %s" % websocket_url)
	add_to_group("SocketManager")
	var error: Error = socket.connect_to_url(websocket_url)
	if error != OK:
		print("Got error %s when trying to establish socket connection, maybe check whether the server is online" % str(error))
		set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	socket.poll()
	var state : WebSocketPeer.State = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var packetString: String = socket.get_packet().get_string_from_utf8()
			print("Got data from server: ", packetString)
			if JSON.parse_string(packetString) != null:
				var parsed : Dictionary = JSON.parse_string(packetString)
				json_parser.parse(parsed)
			
	elif state == WebSocketPeer.STATE_CLOSING:
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code: int = socket.get_close_code()
		print("Web socket connection closed with code %d" % code)
		set_process(false)
		
func cleanup() -> void:
	socket.close(1000, "Socket manager closed")
	var status : WebSocketPeer.State = socket.get_ready_state()
	var try : int = 0
	while(status != WebSocketPeer.STATE_CLOSED && try < 100):
		socket.poll()
		status = socket.get_ready_state()
		try += 1

func _on_json_parser_encoder_changed(player_id: int, change: int) -> void:
	encoder_changed.emit(player_id, change)

func _on_json_parser_item_changed(player_id: int, newItem: int) -> void:
	item_changed.emit(player_id, newItem)
