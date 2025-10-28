class_name AttackStart
extends Node
func checkAnim(atk, startup, active):

	if active:
		return "AttackAct"
	else:
		return "AttackStart"
