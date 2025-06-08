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
var air_block =  false
var neutral_jump = false
var land
#attack states
var punch =  false
var punch_hit = false
var punch_whiff = false

var kick = false
var kick_hit = false
var kick_whiff = false

var instru = false
var instru_hit = false
var instru_whiff = false

var easy_special = false
var easy_special_hit = false
var easy_special_whiff = false

var special_attack = false
var special_hit
var special_whiff = false

var jump_p
var jump_k
var jump_i
var jump_s
var jump_special

var hitstun
var wake_up
var grounded

var jump_options = ["land", "air_block","jump_p", "jump_k", "jump_i", "jump_s", "jump_special", "hitstun"]
var neutral_states = ["idle","crouch", "walk", "run", "back_walk", "down_back", "hitstun"]
var jumps = ["forward_jump","back_jump","neutral_jump", "hitstun"]
var nex_statt_state = {"idle": true}
 #Maybe use key to try and get the statee

func stateRules(current_state, next_state):#The purpose of this is to tell the game whether or not its allowed to go to the next state depending on what the previous state is
	match current_state:#this is like a switch case
		"idle":#not moving options
			return not moveJumpRules(next_state)
		"crouch_state":
			return not moveJumpRules(next_state)
		"walk":#moving options
			return not moveJumpRules(next_state)
		"run":
			return not moveJumpRules(next_state)
		"back_walk":
			return not moveJumpRules(next_state)
		"down_back":
			return not moveJumpRules(next_state)
		"forward_jump":#air options
			return moveJumpRules(next_state)
		"back_jump":
			return moveJumpRules(next_state)
		"neutral_jump":
			return moveJumpRules(next_state)
		"air_block":
			return moveJumpRules(next_state)
		"land":
			return not moveJumpRules(next_state)
		"punch": #punch attacks
			return attackStartState("punch", next_state)
		"punch_hit":
			return gatlinks(["kick","instru", "easy_special", "special","super"], next_state)
		"punch_whiff":
			return whiffs(next_state)
		"kick": #kick attacks
			return attackStartState("kick", next_state)
		"kick_hit":
			return gatlinks(["instru", "easy_special", "special","super"], next_state)
		"kick_whiff":
			return whiffs(next_state)
		"instru": #instrument attacks
			return attackStartState("instru", next_state)
		"instru_hit":
			return gatlinks(["easy_special", "special", "super"], next_state)
		"instru_whiff":
			return whiffs(next_state)
		"easy_special": #eays special attacks
			return attackStartState("easy_special", next_state)
		"easy_special_hit":
			return gatlinks(["super"], next_state)
		"easy_special_whiff":
			return whiffs(next_state)
		"special": #special attacks
			return attackStartState("special", next_state)
		"special_hit":
			return gatlinks(["super"], next_state)
		"special_whiff":
			return whiffs(next_state)
		"super":
			return whiffs(next_state)
		"air_attack":
			return not moveJumpRules(next_state)
		"hitstun":
			return whiffs(next_state)
		"grounded":
	

func moveJumpRules(next_state):
	if next_state in jump_options:
		return true
	else:
		return false

func attackStartState(attack, next_state):#this is to return true if attack will whiff or hit
	var hit = attack +"_hit"
	var whiff = attack +"_whiff"
	
	if next_state == hit:
		return true
	elif next_state == whiff:
		return true
	elif next_state == "hitstun":
		return true
	else:
		return false

func gatlinks(change_attack, next_state):#for if the attack hits
	if next_state in change_attack:
		return true
	elif next_state == "hitstun":
		return true
	else:
		return false
	
func whiffs(next_state):
	if next_state in neutral_states:
		return true
	elif next_state in jumps:
		return true
	else:
		return false
