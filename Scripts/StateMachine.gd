class_name uniStateMachine
extends Node
#This is the univeresal statew machinbe, this variables will go unused for now but use it to keep track of states in future!
var idle_state = true
var crouch_state = false
var walk_state = false
var run_state = false
var back_walk_state = false
var down_back_state = false
#Jump states
var forward_jump = false
var back_jump =  false
var block_jump =  false
var neutral_jump = false
#attack states
var high_p = false
var mid_p = false
var low_p = false

var high_k = false
var mid_k = false
var low_k = false

var high_i = false
var mid_i = false
var low_i = false

var high_s = false
var mid_s = false
var low_s = false

var special_attack = false
var special_hit
var special
var nex_statt_state = {"idle": true}
 #Maybe use key to try and get the statee

func stateRules(current_state, next_state):#The purpose of this is to tell the game whether or not its allowed to go to the next state depending on what the previous state is
	match current_state:#this is like a switch case
		"idle":
			return true
		"crouch_state":
			return true
	
