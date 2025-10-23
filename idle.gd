class_name Idle
extends Node2D
func IdleState(moving_right, moving_left, moving_down, jump, punch, kick, instru, easy_special, buffer):
	var allinputs = [moving_right, moving_left, moving_down, jump, punch, kick, instru, easy_special]
	var attackPuts = [punch, kick, instru, easy_special]
	var mvePuts = [moving_right, moving_left, moving_down, jump]
	var inputValue = "5"
	var charX = 0;#this should equal the x direction of the character
	if moving_down == true:
		if not (true in allinputs):
			return "Idle"
		elif not (true in attackPuts):
			if (moving_down && (moving_right && charX == -1) ||(moving_left && charX == 1)):
				inputValue = "1"
				return "Down_Back"
			elif (moving_down && (moving_right && charX == 1) ||(moving_left && charX == -1)):
				inputValue = "3"
				return "Down_Forward"
			elif (moving_right && charX == 1) ||(moving_left && charX == -1):
				inputValue = "6"
				return "Forward"
			elif (moving_right && charX == -1) ||(moving_left && charX == 1):
				inputValue = "4"
				return ["Backward", "4"]
			elif moving_down:
				inputValue = "2"
				return ["Crouch","2"]
		elif not(true in mvePuts):
			if punch:
				inputValue = "5P"
				buffer.inputGrab(inputValue)
				var atk = buffer.motionGet()
				return ["AttackStart", atk]
			elif kick:
				inputValue = "5K"
				buffer.inputGrab(inputValue)
				var atk = buffer.motionGet()
				return ["AttackStart", atk]
			elif instru:
				inputValue = "5I"
				buffer.inputGrab(inputValue)
				var atk = buffer.motionGet()
				return ["AttackStart", atk]
			elif easy_special:
				inputValue = "5S"
				buffer.inputGrab(inputValue)
				var atk = buffer.motionGet()
				return ["AttackStart", atk]
		else:
			if moving_down:
				pass
			elif (moving_right && charX == 1) ||(moving_left && charX == -1):
				pass
			elif (moving_right && charX == -1) ||(moving_left && charX == 1):
				pass
	else:
		pass
