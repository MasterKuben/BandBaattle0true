extends CharacterBody2D

@export var playerIndex: int = 0 #set this when character is made when they are selected by player 1 or 2
@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 0
@export var max_fall_speed: float = 1000.0
@export var entType:String = "player%s"% [playerIndex]
var statePriority = ["ground_reversal", "air_reversal", "neutral_jump", "super", "special", "easy_special", "instru", "kick", "punch"]
var neutral
var animInput = "5"
var bufferTime = 5
var stateNput = ["0",""]
var current_state = "idle"
var bufferInput = null
@onready var stateCheck = $uniStateMachine

func _physics_process(delta: float) -> void:
	stateNput = inputProcessor(delta)
	animInput = stateNput[0]
	var state = stateNput[1]
	#Fix buffer system
	if stateCheck.stateCancels(current_state, state):
		current_state = state
		playAnim(animInput)
	elif bufferTime == 0 && bufferInput != null:
		playAnim(bufferInput)
		bufferInput = null
	elif bufferTime == 0 && animInput != "5":
		playAnim(animInput)
	elif bufferTime != 0 && animInput != "5":
		var newInfo = bufferPriority(animInput, bufferInput, bufferTime, statePriority)
		bufferInput = newInfo[0]
		bufferTime = newInfo[1]
	
func playAttack(motion, atk):
	neutral = false
	if motion == null:
		return atk
	else:
		return motion
		print("You can now do special inputs")
		print(motion)
		#make it flip if player is flipped

func bufferPriority(newBuff, oldBuff, framesTilluse, buffOrder):#this is to prioritize an input thats being held in buffer in case one has higher priority than other, e.g special over normal attack
	var order = 0 #rest buffer time if new input has higher priority
	for x in statePriority:
		if oldBuff == x:
			return [oldBuff, framesTilluse-1]
		else:
			return [newBuff, 5]
		

func useforrealprocess(bufferState, timeToBuff): #user this logic for the main code
	if timeToBuff == 0:
		bufferState = null
	if bufferState == null:
		#do the input no problem
		pass
	else:
		#check to see if something besides buffered input is being done
		#first check if the current state is a can be cancled by something else
		#if yes, then check if buffered input state can be the next cancled into state, if no then check if the buffered state will be the next state
		pass

func inputProcessor(delta):#use this to do inputs
	var velocity = self.velocity
	neutral = true #checks if nothing has been input
	var buffer = $inputBuffer
	buffer.motionGet()
	# Apply gravity
	
	# Move left and right
	var moving_right = Input.is_action_pressed("right%s" % [playerIndex])
	var moving_left = Input.is_action_pressed("left%s" % [playerIndex])
	var moving_down = Input.is_action_pressed("down%s" % [playerIndex])
	var punch = Input.is_action_just_pressed("P%s" % [playerIndex])
	var kick = Input.is_action_just_pressed("K%s" % [playerIndex])
	var instru = Input.is_action_just_pressed("IS%s" % [playerIndex])
	var easy_special = Input.is_action_just_pressed("S%s" % [playerIndex])
	var playerPut = "5"
	var inputs = [moving_down,moving_right,moving_left,punch,kick,instru,easy_special]
	var inputs_true = []
	for x in inputs:
		if x == true:
			inputs_true.append(x)
	
	match inputs_true:
		[moving_left]:
			neutral = false
			velocity.x = -speed
			if $Sprite2D.scale.x < 0:
				buffer.inputGrab("4")  # pressing left while facing right
			else:
				buffer.inputGrab("6")  # pressing left while facing left
		[moving_right]:
			neutral = false
			velocity.x = speed
			if $Sprite2D.scale.x > 0:
				buffer.inputGrab("6")  # pressing right while facing right
			else:
				buffer.inputGrab("4")  # pressing right while facing left
		[moving_down]:
			neutral = false
			buffer.inputGrab("2")
		[moving_down,moving_left]:
			neutral = false
			if $Sprite2D.scale.x < 0:
				buffer.inputGrab("1")  # pressing left while facing right
			else:
				buffer.inputGrab("3")
		[moving_down,moving_right]:
			neutral = false
			if $Sprite2D.scale.x > 0:
				buffer.inputGrab("3")  # pressing right while facing right
			else:
				buffer.inputGrab("1")
		[moving_down,punch]:
			neutral = false
			buffer.inputGrab("2")
			buffer.inputGrab("P")
			#add motion check if needed
			playerPut = "2P"
			return playerPut
		[moving_down,kick]:
			neutral = false
			buffer.inputGrab("2")
			buffer.inputGrab("K")
			#add motion check if needed
			playerPut = "2K"
			return playerPut
		[moving_down,instru]:
			neutral = false
			buffer.inputGrab("2")
			buffer.inputGrab("I")
			#add motion check if needed
			playerPut = "2I"
			return playerPut
		[moving_down,easy_special]:
			neutral = false
			buffer.inputGrab("2")
			buffer.inputGrab("S")
			#add motion check if needed
			playerPut = "2S"
			return playerPut
		[moving_left, punch]:
			neutral = false
			if $Sprite2D.scale.x < 0:
				buffer.inputGrab("4")  
				buffer.inputGrab("P")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "4P")
				return [playerPut,"punch"]
			else:
				buffer.inputGrab("6")  
				buffer.inputGrab("P")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "6P")
				return [playerPut,"punch"]
		[moving_left, kick]:
			neutral = false
			if $Sprite2D.scale.x < 0:
				buffer.inputGrab("4")  # pressing left while facing right
				buffer.inputGrab("K")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "4K")
				return [playerPut,"kick"]
			else:
				buffer.inputGrab("6")  # pressing left while facing left
				buffer.inputGrab("K")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "6K")
				return [playerPut,"kick"]
		[moving_left, instru]:
			neutral = false
			if $Sprite2D.scale.x < 0:
				buffer.inputGrab("4")  # pressing left while facing right
				buffer.inputGrab("I")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "4I")
				return [playerPut,"instru"]
			else:
				buffer.inputGrab("6")  # pressing left while facing left
				buffer.inputGrab("I")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "6I")
				return [playerPut,"instru"]
		[moving_left, easy_special]:
			neutral = false
			if $Sprite2D.scale.x < 0:
				buffer.inputGrab("4")  # pressing left while facing right
				buffer.inputGrab("S")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "4S")
				return [playerPut,"easy_special"]
			else:
				buffer.inputGrab("6")  # pressing left while facing left
				buffer.inputGrab("S")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "6S")
				return [playerPut,"easy_special"]
		[moving_right, punch]:
			neutral = false
			velocity.x = speed
			if $Sprite2D.scale.x > 0:
				buffer.inputGrab("6")  
				buffer.inputGrab("P")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "6P")
				return [playerPut,"punch"]
			else:
				buffer.inputGrab("4")  
				buffer.inputGrab("P")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "4P")
				return [playerPut,"punch"]
		[moving_right, kick]:
			neutral = false
			velocity.x = speed
			if $Sprite2D.scale.x > 0:
				buffer.inputGrab("6")  
				buffer.inputGrab("K")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "6K")
				return [playerPut,"kick"]
			else:
				buffer.inputGrab("4")  
				buffer.inputGrab("K")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "4K")
				return [playerPut,"kick"]
		[moving_right, instru]:
			neutral = false
			velocity.x = speed
			if $Sprite2D.scale.x > 0:
				buffer.inputGrab("6")  
				buffer.inputGrab("I")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "6I")
				return [playerPut,"instru"]
			else:
				buffer.inputGrab("4")  
				buffer.inputGrab("I")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "4I")
				return [playerPut,"instru"]
		[moving_right, easy_special]:
			neutral = false
			velocity.x = speed
			if $Sprite2D.scale.x > 0:
				buffer.inputGrab("6")  
				buffer.inputGrab("S")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "6S")
				return [playerPut,"easy_special"]
			else:
				buffer.inputGrab("4")  
				buffer.inputGrab("S")
				var motion = buffer.motionGet()
				playerPut = playAttack(motion, "4S")
				return [playerPut,"easy_special"]
		#add command normal like using the above system, use action Just pressed for attacks
		
		
	if velocity.x:
		$Sprite2D.flip_h = velocity.x < 0
		#play walking anim
	
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)
	else:
		# Jump
		if Input.is_action_just_pressed("up%s"% [playerIndex]):
			velocity.y = jump_velocity
			#make jump arc
			#PUT INPUT FOR ATTACKS HERE ONMCE UVE MADE A STAGE

			
	if Input.is_action_just_pressed("K%s"% [playerIndex]):
		buffer.inputGrab("K")
		var motion = buffer.motionGet()
		playerPut = playAttack(motion, "5K")
		return [playerPut,"kick"]
	elif Input.is_action_pressed("P%s" % [playerIndex]):
		buffer.inputGrab("P")
		var motion = buffer.motionGet()
		playerPut = playAttack(motion, "5P")
		return [playerPut,"punch"]
	elif Input.is_action_pressed("S%s" % [playerIndex]):
		buffer.inputGrab("S")
		var motion = buffer.motionGet()
		playerPut = playAttack(motion, "5S")
		return [playerPut,"easy_special"]
	elif Input.is_action_pressed("I%s" % [playerIndex]):
		buffer.inputGrab("I")
		var motion = buffer.motionGet()
		playerPut = playAttack(motion, "5I")
		return [playerPut,"instru"]

	if neutral:
		if not is_on_floor():
			buffer.inputGrab("5")
			return ["5","idle"] # this should be neutral jump later
		else:
			buffer.inputGrab("5")
			return ["5","idle"]
	# Move the character
	self.velocity = velocity
	move_and_slide()
	return ["5","idle"]
	
func playAnim(animInput):
	if animInput == "5":
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play(animInput)
