extends Node

func jumpCheck(on_ground, anim_end, ):
	if on_ground && not anim_end:
		var velocity = -50
		return ["Jump",velocity]
	
