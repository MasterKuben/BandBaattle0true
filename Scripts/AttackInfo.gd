class_name attackInfo
extends Node2D
var PATH = "res://Assets/CharData/Char_Damage_Stun.json"

func load_json_file():
	var file = FileAccess.get_file_as_string(PATH)
	var json_data
	if file != null:
		json_data = JSON.parse_string(file)
	else:
		push_warning("function failed get_file_as_string for path", PATH)
	if json_data == null:
		push_error("Function failed tro parse file data to JSON for", PATH)
	return json_data
	

func attackDam(charName, atkName):
	var atkData = load_json_file()
	var sheet = atkData["Damage"]
	var atkDict = sheet[charName]
	return atkDict[atkName]

func attackStun(charName, atkName):
	var atkData = load_json_file()
	var sheet = atkData["Stun"]
	var atkDict = sheet[charName]
	return atkDict[atkName]
