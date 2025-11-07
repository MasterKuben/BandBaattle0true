class_name AttackRec
extends Node

@onready var canCheck = $cancelCheck

func Recovery(atk, cancelWin, recovery, new_move, charName, moving_down):
	var cancelMove
	if cancelWin == true:
		cancelMove = canCheck.getCancels(atk, new_move, charName)
		if cancelMove:
			return ["AttackStart", new_move]
	elif moving_down && recovery == false:
		return["Crouch", "2"]
	elif recovery == false:
		return["Idle", "5"]
	else:
		return ["AttackRec", new_move]
