extends CharacterBody2D

@export var playerIndex: int = 0 #set this when character is made when they are selected by player 1 or 2
@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 0
@export var max_fall_speed: float = 1000.0
@export var entType:String = "player%s"% [playerIndex]
var statePriority = ["ground_reversal", "air_reversal", "neutral_jump", "super", "special", "easy_special", "instru", "kick", "punch",]
var neutral

func _physics_process(delta: float) -> void:
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
			$AnimationPlayer.play("2P")
		[moving_down,kick]:
			neutral = false
			buffer.inputGrab("2")
			buffer.inputGrab("K")
			#add motion check if needed
			$AnimationPlayer.play("2K")
		[moving_down,instru]:
			neutral = false
			buffer.inputGrab("2")
			buffer.inputGrab("I")
			#add motion check if needed
			$AnimationPlayer.play("2I")
		[moving_down,easy_special]:
			neutral = false
			buffer.inputGrab("2")
			buffer.inputGrab("S")
			#add motion check if needed
			$AnimationPlayer.play("2S")
		[moving_left, punch]:
			neutral = false
			if $Sprite2D.scale.x < 0:
				buffer.inputGrab("4")  
				buffer.inputGrab("P")
				var motion = buffer.motionGet()
				playAttack(motion, "4P")
			else:
				buffer.inputGrab("6")  
				buffer.inputGrab("P")
				var motion = buffer.motionGet()
				playAttack(motion, "6P")
		[moving_left, kick]:
			neutral = false
			if $Sprite2D.scale.x < 0:
				buffer.inputGrab("4")  # pressing left while facing right
				buffer.inputGrab("K")
				var motion = buffer.motionGet()
				playAttack(motion, "4K")
			else:
				buffer.inputGrab("6")  # pressing left while facing left
				buffer.inputGrab("K")
				var motion = buffer.motionGet()
				playAttack(motion, "6K")
		[moving_left, instru]:
			neutral = false
			if $Sprite2D.scale.x < 0:
				buffer.inputGrab("4")  # pressing left while facing right
				buffer.inputGrab("I")
				var motion = buffer.motionGet()
				playAttack(motion, "4I")
			else:
				buffer.inputGrab("6")  # pressing left while facing left
				buffer.inputGrab("I")
				var motion = buffer.motionGet()
				playAttack(motion, "6I")
		[moving_left, easy_special]:
			neutral = false
			if $Sprite2D.scale.x < 0:
				buffer.inputGrab("4")  # pressing left while facing right
				buffer.inputGrab("S")
				var motion = buffer.motionGet()
				playAttack(motion, "4S")
			else:
				buffer.inputGrab("6")  # pressing left while facing left
				buffer.inputGrab("S")
				var motion = buffer.motionGet()
				playAttack(motion, "6S")
		[moving_right, punch]:
			neutral = false
			velocity.x = speed
			if $Sprite2D.scale.x > 0:
				buffer.inputGrab("6")  
				buffer.inputGrab("P")
				var motion = buffer.motionGet()
				playAttack(motion, "6P")
			else:
				buffer.inputGrab("4")  
				buffer.inputGrab("P")
				var motion = buffer.motionGet()
				playAttack(motion, "4P")
		[moving_right, kick]:
			neutral = false
			velocity.x = speed
			if $Sprite2D.scale.x > 0:
				buffer.inputGrab("6")  
				buffer.inputGrab("K")
				var motion = buffer.motionGet()
				playAttack(motion, "6K")
			else:
				buffer.inputGrab("4")  
				buffer.inputGrab("K")
				var motion = buffer.motionGet()
				playAttack(motion, "4K")
		[moving_right, instru]:
			neutral = false
			velocity.x = speed
			if $Sprite2D.scale.x > 0:
				buffer.inputGrab("6")  
				buffer.inputGrab("I")
				var motion = buffer.motionGet()
				playAttack(motion, "6I")
			else:
				buffer.inputGrab("4")  
				buffer.inputGrab("I")
				var motion = buffer.motionGet()
				playAttack(motion, "4I")
		[moving_right, easy_special]:
			neutral = false
			velocity.x = speed
			if $Sprite2D.scale.x > 0:
				buffer.inputGrab("6")  
				buffer.inputGrab("S")
				var motion = buffer.motionGet()
				playAttack(motion, "6S")
			else:
				buffer.inputGrab("4")  
				buffer.inputGrab("P")
				var motion = buffer.motionGet()
				playAttack(motion, "4S")
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
		playAttack(motion, "5K")
	elif Input.is_action_pressed("P%s" % [playerIndex]):
		buffer.inputGrab("P")
		var motion = buffer.motionGet()
		playAttack(motion, "5P")
	elif Input.is_action_pressed("S%s" % [playerIndex]):
		buffer.inputGrab("S")
		var motion = buffer.motionGet()
		#playAttack(motion, "5S")
	elif Input.is_action_pressed("I%s" % [playerIndex]):
		buffer.inputGrab("I")
		var motion = buffer.motionGet()
		playAttack(motion, "5I")

	if neutral:
		buffer.inputGrab("5")
	# Move the character
	self.velocity = velocity
	move_and_slide()
	
	
func playAttack(motion, atk):
	neutral = false
	if motion == null:
		$AnimationPlayer.play(atk)
	else:
		$AnimationPlayer.play(motion)
		print("You can now do special inputs")
		print(motion)
		#make it flip if player is flipped

func bufferPriority(newBuff, oldBuff, framesTilluse, buffOrder):#this is to prioritize an input thats being held in buffer in case one has higher priority than other, e.g special over normal attack
	var order = 0 #rest buffer time if new input has higher priority
	for x in statePriority:
		if oldBuff == buffOrder[order]:
			return [oldBuff, framesTilluse]
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

func inputProcessor():#use this to do inputs
	#Put move underneth
	
	#put neutral attacks
	
	pass
	
func leftInputs(input):
	pass

func rightInputs(input):
	pass
