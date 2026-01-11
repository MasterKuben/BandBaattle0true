class_name knockdown
extends Node

var direction =[]
var attakcs =[]

func inputs(atk_btn, dir_btn):#If user press a button while knocked down, they will be put in idle
	if true in atk_btn:
		return "Idle"
	elif true in dir_btn:
		return "Idle"
	else:
		return "Knockdown"
