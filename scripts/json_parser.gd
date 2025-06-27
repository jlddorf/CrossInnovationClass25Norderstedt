class_name JSONParser
extends Node

const INPUT_KEY_DEVICE_TYPE: String = "device_type"
const INPUT_KEY_DEVICE_ID: String = "device_id"
const INPUT_KEY_BUTTON_PRESSED: String = "button_pressed"
const INPUT_KEY_ENCODER_DIRECTION: String = "encoder_direction"
const INPUT_KEY_RFID_CONTENT: String = "rfid_content"

const DEVICE_ENCODER: String = "encoder"
const DEVICE_BUTTON: String = "button"
const DEVICE_ENCODER_BUTTON: String = "encoder_button"
const DEVICE_RFID_READER: String = "rfid_reader"
const CustomTypes = preload("res://scripts/custom_types.gd")

signal item_changed(player_id: int, newItem: CustomTypes.Item)
signal encoder_changed(player_id: int, change: int)

# Parses the object and relays it further. The input is expected to be in accordance 
# with the input specification in the README
func parse(json_object: Dictionary) -> void:
	# Check for the mandatory JSON keys
	if json_object.get(INPUT_KEY_DEVICE_TYPE) == null:
		print("Found no device type, cancelling parsing of input")
		return 
	if json_object.get(INPUT_KEY_DEVICE_ID) == null:
		print("Found no device id, cancelling parsing of input")
		return 
	var device_type: String = json_object.get(INPUT_KEY_DEVICE_TYPE)
	var device_id : int = json_object.get(INPUT_KEY_DEVICE_ID) as int
	match device_type :
		DEVICE_RFID_READER:
			var selected_item: String = json_object.get(INPUT_KEY_RFID_CONTENT, "") if json_object.get(INPUT_KEY_RFID_CONTENT, "") != null else ""
			var item : CustomTypes.Item
			match selected_item:
				"tree": 
					item = CustomTypes.Item.NATURE
				_: 
					item = CustomTypes.Item.NONE
			item_changed.emit(device_id, item) 
		DEVICE_ENCODER:
			var change: int = json_object.get(INPUT_KEY_ENCODER_DIRECTION, 0) if json_object.get(INPUT_KEY_ENCODER_DIRECTION, 0) != null else 0
			encoder_changed.emit(device_id, change)
		
