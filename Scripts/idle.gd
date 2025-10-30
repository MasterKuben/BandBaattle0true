class_name Idle
extends Node2D
func IdleState(moving_right, moving_left, moving_down, jump, punch, kick, instru, easy_special, buffer):
	var allinputs = [moving_right, moving_left, moving_down, jump, punch, kick, instru, easy_special]
	var attackPuts = [punch, kick, instru, easy_special]
	var mvePuts = [moving_right, moving_left, moving_down, jump]
	var inputValue = "5"
	var charX = 1;#this should equal the x direction of the character
	if moving_down == false ||moving_down:#cahnge this to is on floor and is not on floor 
		if not (true in allinputs):
			return ["Idle","5"]
		elif not (true in attackPuts): #for when movement is done with no attacks
			if (moving_down && ((moving_right && charX == -1) ||(moving_left && charX == 1))):
				inputValue = "1"
				return ["Down_Back","1"]
			elif (moving_down && (moving_right && charX == 1) ||(moving_left && charX == -1)):
				inputValue = "3"
				return ["Crouch","3"]
			elif (moving_right && charX == 1) ||(moving_left && charX == -1):
				inputValue = "6"
				return ["Forward","6"]
			elif (moving_right && charX == -1) ||(moving_left && charX == 1):
				inputValue = "4"
				return ["Backward", "4"]
			elif moving_down:
				inputValue = "2"
				return ["Crouch","2"]
		elif not(true in mvePuts):#for when moves are done in neutral
			if punch:
				inputValue = "5P"
			elif kick:
				inputValue = "5K"
			elif instru:
				inputValue = "5I"
			elif easy_special:
				inputValue = "5S"
			return ["AttackStart", inputValue]
		else:
			if moving_down:
				if punch:
					inputValue = "2P"
				elif kick:
					inputValue = "2K"
				elif instru:
					inputValue = "2I"
				elif easy_special:
					inputValue = "2S"
				return ["AttackStart", inputValue]
			elif (moving_right && charX == 1) ||(moving_left && charX == -1):
				if punch:
					inputValue = "6P"
				elif kick:
					inputValue = "6K"
				elif instru:
					inputValue = "6I"
				elif easy_special:
					inputValue = "6S"
				return ["AttackStart", inputValue]
			elif (moving_right && charX == -1) ||(moving_left && charX == 1):
				if punch:
					inputValue = "4P"
				elif kick:
					inputValue = "4K"
				elif instru:
					inputValue = "4I"
				elif easy_special:
					inputValue = "4S"
				return ["AttackStart", inputValue]
	else:
		pass
