extends Node2D
func IdleState(moving_right, moving_left, moving_down, jump, punch, kick, instru, easy_special):
	var buffer = $inputBuffer
	if moving_down == true:
