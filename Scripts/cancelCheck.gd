class_name cancelCheck
extends Node



#this should pull from of json list of cancelable moves from a json file

func getCancels(atk, newAtk, char_name):
	#this should grab the cancels from the json for the move and check if its fine
	var file = "res://CharData/"+char_name+"Cancels.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	
	var listAtk = json_as_dict[atk]
	
	if newAtk in listAtk:
		return true
	else:
		return false
	
	
