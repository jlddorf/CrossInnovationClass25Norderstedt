# Interactive Map

An interactive map game created during the Cross Innovation Class 2025

## Input format

The input that is sent by the Web Socket follows the JSON standard and is organized in the following structure:

- **device_type** (String): The type of the input device. Must be one of "encoder", "rfid_reader", "button", "encoder_button"
- **device_id** (Number): The id of the input device. This is identical to the stations id.
- **rfid_content** (String): Only exists when the device type is "rfid_sensor". Contains the read content of the rfid reader
- **encoder_direction** (Number): Only exists when the device type is "encoder" or "encoder_button. Contains the direction the encoder was turned in. One of -1, 0, 1.
- **button_pressed** (Boolean): Only exists when the device type is "button" or "encoder_button". Marks whether the button has been pressed

## Input types

The RFID content string must be equal to one of the following values in respect to the category, other values including null will be interpreted as an empty station:

- "nature"
- "mobility"
- "energy_building"
- "community"
- "circular_economy"
- "local_consumption"
