extends CharacterBody2D

@onready var buffer = $inputBuffer
@onready var IdleState = $Idle
@onready var aActive = $AttackAct
@onready var aStartState = $AttackStart
@onready var aRec = $AttackRec
@onready var direction = 1
@onready var replay = $replayRecord
@onready var healthbar = $healthbar

@export var flip = false
@export var playerIndex: int = 0 #set this when character is made when they are selected by player 1 or 2
@export var entType:String = "player0" #"player%s"% [playerIndex]
@export var cancelWin = false
@export var startup = false
@export var active = false
@export var recovery = false

var health
var previous_state := ""
var CurrentState = "Idle"
var atk
var dashMod = 8
var speed = 200
var hit = false
var charName = "TestMan"#fix this at some point so it actually gets the characters name

func _ready() -> void:
	health =  1000#this should be collected using character data
	$AnimationPlayer.animation_finished.connect(_on_animation_player_animation_finished)
	add_to_group("player1hithurt")
	healthbar._init_health(health)


func _physics_process(delta: float) -> void:
	
	#if CurrentState != previous_state:
		#on_state_enter(CurrentState)
		#previous_state = CurrentState
	
	var moving_right = Input.is_action_pressed("right%s" % [playerIndex])
	var moving_left = Input.is_action_pressed("left%s" % [playerIndex])
	var moving_down = Input.is_action_pressed("down%s" % [playerIndex])
	var jump = Input.is_action_just_pressed("up%s"[playerIndex])
	var movementInputs = [moving_right, moving_left, moving_down, jump]
	
	var light = Input.is_action_just_pressed("L%s" % [playerIndex])
	var heavy = Input.is_action_just_pressed("H%s" % [playerIndex])
	var instru = Input.is_action_just_pressed("I%s" % [playerIndex])
	var easy_special = Input.is_action_just_pressed("S%s" % [playerIndex])
	var dash = Input.is_action_just_pressed("D%s" % [playerIndex])
	
	
	if hit == false:
		match CurrentState:
			"Idle","Down_Back":
				#$AnimationPlayer.play(CurrentState)
				$AnimationPlayer.play("Idle")
				#var StateInput = IdleState.IdleState(moving_right, moving_left, moving_down, jump, light, heavy, instru, easy_special, buffer)
				#buffer.inputGrab(StateInput[1])
				#atk = getSpecial(StateInput[1])
				#CurrentState = StateInput[0]
				neutral_states(dash,moving_right, moving_left, moving_down, jump, light, heavy, instru, easy_special, buffer, direction)
				print(direction)
			"Crouch":
				var StateInput = IdleState.IdleState(dash, moving_right, moving_left, moving_down, jump, light, heavy, instru, easy_special, buffer, direction)
				buffer.inputGrab(StateInput[1])
				atk = getSpecial(StateInput[1])
				CurrentState = StateInput[0]
			"AttackStart":
				#write this to read inputs that happen during this part
				CurrentState = aStartState.checkAnim(atk, startup, active)
				var inputValue = IdleState.IdleState(dash, moving_right, moving_left, moving_down, jump,light, heavy, instru, easy_special, buffer, direction)
				buffer.inputGrab(inputValue[1])
				if CurrentState == "AttackStart":
					$AnimationPlayer.play(atk)
			"AttackAct":
				var inputValue = IdleState.IdleState(dash, moving_right, moving_left, moving_down, jump, light, heavy, instru, easy_special, buffer, direction)
				buffer.inputGrab(inputValue[1])
				atk = inputValue[1]
				var newAtk = getSpecial(atk)
				var Statenmove = aActive.checkAnimation(atk, cancelWin, active, newAtk, charName)
				CurrentState = Statenmove[0]
				atk = Statenmove[1]
			"AttackRec":
				var inputValue = IdleState.IdleState(dash, moving_right, moving_left, moving_down, jump, light, heavy, instru, easy_special, buffer, direction)
				buffer.inputGrab(inputValue[1])
				atk = inputValue[1]
				var newAtk = getSpecial(atk)
				var Statenmove = aRec.Recovery(atk, cancelWin, recovery, newAtk, charName, moving_down)
				CurrentState = Statenmove[0]
				atk = Statenmove[1]
			"Hitstun":
				pass
			"Forward":
				$AnimationPlayer.play(CurrentState)
				neutral_states(dash, moving_right, moving_left, moving_down, jump, light, heavy, instru, easy_special, buffer, direction)
				movemoment(moving_left, moving_right)
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
			"Down_Back":
				pass
			"Turn":
				if $AnimationPlayer.current_animation != "turnAround":
					$AnimationPlayer.play("turnAround")
					direction *= -1
					apply_scale(Vector2(-1,1))  # flip relative to current orientation
					movemoment(moving_left, moving_right)
			"Dash":
				#there is something wrong with this state but fix at a later time
				if $AnimationPlayer.current_animation != "Dash":
					$AnimationPlayer.play("Dash")
				movemoment(moving_left, moving_right)
			#"BackDash":
				#pass
			"Jump":
				pass
			"Fall":
				pass
			"Air_Dash":
				pass
			"Block":
				#block_meter += -1
				pass
			"BlockStun":
				pass
			"Grab":
				pass
			"GrabStun":
				$AnimationPlayer.play("GrabStun")
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
			#"Down_Back":
				#pass
			#"Backward":
				#pass
			"Hitstun":
				var ranHit = randi_range(1,5)#this will choose one of 5 random frames for a hit on a character
			"Block":
				#block_meter += blockdamage
				
				pass
			"BlockStun":
				pass
			_:#this is default for any other state a player can be hit in.
				pass
	#flipChar(moving_right, moving_left)
	replay.recordStates(CurrentState, atk)

func getSpecial(tempatk):
	var newAtk = buffer.motionGet()
	if newAtk == null:
		return tempatk
	else:
		return newAtk

func neutral_states(dash,moving_right, moving_left, moving_down, jump, light, heavy, instru, easy_special, buffer, direction):
				var StateInput = IdleState.IdleState(dash, moving_right, moving_left, moving_down, jump, light, heavy, instru, easy_special, buffer, direction)
				buffer.inputGrab(StateInput[1])
				atk = getSpecial(StateInput[1])
				CurrentState = StateInput[0]
				print(CurrentState, atk)

func movemoment(moving_left, moving_right):
	if true: # while facing right
		if CurrentState == "Forward":
			self.velocity.x = speed*direction
		elif CurrentState == "Dash":
			self.velocity.x = speed*dashMod*direction
		elif CurrentState == "Backward":
			self.velocity.x = speed*0.7*direction
			#if moving_left:
			#	self.scale.x = -1
			#	direction = -1
			#elif moving_right:
			#	self.scale.x = 1
			#	direction = 1
			
		move_and_slide()
	#elif direction == 1:
	#	if CurrentState == "Forward":
	#		self.velocity.x = speed
	#	elif CurrentState == "Dash":
	#		self.velocity.x = speed*dashMod
	#	elif CurrentState == "Backward":
	#		self.velocity.x = -speed*0.7
	#	move_and_slide()
	
	pass
func grabCharData():
	pass

#func FlipSprite():
	#scale.x = direction*-1
	#direction = scale.x
	#flip = false
	
func takeDamage(atkDam) -> void:#this is called by the hurtbox node when damage needs to be applied to character
	if health > 0 && atkDam < health:
		if CurrentState == "Block":
			health = health - atkDam*0.2
		else:
			health = health - atkDam
		print(health)
		
	elif health > 0:
		health = 0
	elif health <= 0:
		print("Already dead")
	healthbar.health = health

func disable_Hitboxes() -> void:
	#Ill write something when Im back on this
	pass
	
func setTeam():
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if CurrentState == "Dash":
		CurrentState = "Idle"
	elif CurrentState == "Turn" && anim_name == "turnAround":
		CurrentState = "Idle"
		
func on_state_enter(state):
	if state == "Turn":
		pass
		direction *= -1
		apply_scale(Vector2(-1,1))  # flip relative to current orientation


#func flipChar(moving_right, moving_left):
#	if moving_right:
#		scale.x = 1
#		direction = 1
#	elif moving_left:
#		$Sprite2D.flip_h = true
#		$HurtBox.scale.x = -1
#		direction = -1
