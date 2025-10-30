class_name AttackAct
extends Node

var atk_anim
@onready var canCheck = $cancelCheck
func checkAnimation(atk, cancelWin, active, new_move, charName):
	var cancelMove
	if cancelWin == true:
		cancelMove = canCheck.getCancels(atk, new_move, charName)
		if cancelMove:
			return ["AttackStart", new_move]
	elif active == false:
		return ["AttackRec", "5"]
	elif new_move == null:
		return ["AttackRec", "5"]
	else:
		return ["AttackAct",new_move]
	
