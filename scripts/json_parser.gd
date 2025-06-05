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

var _currentlySelectedObject: String
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
	if device_type == DEVICE_RFID_READER:
		Input.action_release(_currentlySelectedObject)
		# TODO replace with actual logic
		_currentlySelectedObject = "select_icon_tree"
		Input.action_press(_currentlySelectedObject)
		
	
