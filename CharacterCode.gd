extends CharacterBody2D

@onready var buffer = $inputBuffer
@onready var IdleState = $Idle
@onready var aActive = $AttackAct
@onready var aStartState = $AttackStart
@export var playerIndex: int = 0 #set this when character is made when they are selected by player 1 or 2
@export var entType:String = "player%s"% [playerIndex]
@export var cancelWin = false
@export var startup = false
@export var active = false
var CurrentState = "Idle"
var atk
var hit = false
var charName = "TestMan"#fix this at some point so it actually gets the characters name

func _physics_process(delta: float) -> void:
	var moving_right = Input.is_action_pressed("right%s" % [playerIndex])
	var moving_left = Input.is_action_pressed("left%s" % [playerIndex])
	var moving_down = Input.is_action_pressed("down%s" % [playerIndex])
	var jump = Input.is_action_just_pressed("up%s"[playerIndex])
	var movementInputs = [moving_right, moving_left, moving_down, jump]
	
	var punch = Input.is_action_just_pressed("P%s" % [playerIndex])
	var kick = Input.is_action_just_pressed("K%s" % [playerIndex])
	var instru = Input.is_action_just_pressed("IS%s" % [playerIndex])
	var easy_special = Input.is_action_just_pressed("S%s" % [playerIndex])
	if hit == false:
		match CurrentState:
			"Idle":
				var StateInput = IdleState.IdleState(moving_right, moving_left, moving_down, jump, punch, kick, instru, easy_special, buffer)
				buffer.inputGrab(StateInput[1])
				atk = getSpecial(StateInput[1])
				CurrentState = StateInput[0]
				print(CurrentState, atk)
			"Crouch":
				pass
			"AttackStart":
				#write this to read inputs that happen during this part
				CurrentState = aStartState.checkAnim(atk, startup, active)
				var inputValue = IdleState.IdleState(moving_right, moving_left, moving_down, jump, punch, kick, instru, easy_special, buffer)
				buffer.inputGrab(inputValue[1])
				if CurrentState == "AttackStart":
					$AnimationPlayer.play(atk)
			"AttackAct":
				var inputValue = IdleState.IdleState(moving_right, moving_left, moving_down, jump, punch, kick, instru, easy_special, buffer)
				buffer.inputGrab(inputValue[1])
				atk = inputValue[1]
				var newAtk = getSpecial(atk)
				var Statenmove = aActive.checkAnimation(atk, cancelWin, active, newAtk, charName)
				CurrentState = Statenmove[0]
				atk = Statenmove[1]
				
			"AttackRec":
				pass
			"Hitstun":
				pass
			"Forward":
				pass
			"KnockdownFall":
				pass
			"Knockdown":
				pass
			"HardKnockdown":
				pass
			"Super":
				pass
			"Summon":
				pass
			"Forward":
				pass
			"Down_Back":
				pass
			"Backward":
				pass
			"Jump":
				pass
			#put all the directional and movement stuff here
	else:
		match CurrentState:
			"KnockdownFall":
				pass
			"Knockdown":
				pass
			"HardKnockdown":
				pass
			"Down_Back":
				pass
			"Backward":
				pass
			_:#this is default for any other state a player can be hit in.
				pass

func getSpecial(tempatk):
	var newAtk = buffer.motionGet()
	if newAtk == null:
		return tempatk
	else:
		return newAtk
