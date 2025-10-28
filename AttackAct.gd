class_name AttackAct
extends Node

var atk_anim
func checkAnimation(atk, cancelWin, punch, kick, instru, easy_special, moving_down, moving_right, moving_left, new_move, active):
	if cancelWin == true:
		return ["AttackStart", new_move]
	elif active == false:
		return ["AttackRec", "5"]
	else:
		return ["AttackAct","5"]
	

func animationCancel(punch, kick, instru, easy_special, moving_down, moving_right, moving_left, newAtk):
	var attacks = [punch, kick, instru, easy_special]
	#make this basically check if the input attack is in the chars list of canclable attacks
