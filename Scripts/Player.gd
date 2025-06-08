extends CharacterBody2D

@export var playerIndex: int = 0 #set this when character is made when they are selected by player 1 or 2
@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 0
@export var max_fall_speed: float = 1000.0
@export var entType:String = "player%s"% [playerIndex]
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
	
	if moving_left:
		neutral = false
		velocity.x = -speed
		if $Sprite2D.scale.x < 0:
			buffer.inputGrab("4")  # pressing left while facing right
		else:
			buffer.inputGrab("6")  # pressing left while facing left
	elif moving_right:
		neutral = false
		velocity.x = speed
		if $Sprite2D.scale.x > 0:
			buffer.inputGrab("6")  # pressing right while facing right
		else:
			buffer.inputGrab("4")  # pressing right while facing left
	elif moving_down:
		neutral = false
		buffer.inputGrab("2")
	
	if moving_down && moving_left:
		neutral = false
		velocity.x = -speed
		if $Sprite2D.scale.x < 0:
			buffer.inputGrab("1")  # pressing left while facing right
		else:
			buffer.inputGrab("3")
	elif moving_down && moving_right:
		neutral = false
		velocity.x = speed
		if $Sprite2D.scale.x > 0:
			buffer.inputGrab("3")  # pressing right while facing right
		else:
			buffer.inputGrab("1")
		
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
		elif Input.is_action_just_pressed("P%s" % [playerIndex]):
			$AnimationPlayer.play("5P")
		
		elif Input.is_action_just_pressed("K%s"% [playerIndex]):
			buffer.inputGrabber("K") 
			$AnimationPlayer.play("5K")
			
	if Input.is_action_just_pressed("K%s"% [playerIndex]):
		buffer.inputGrab("K")
		var motion = buffer.motionGet()
		playAttack(motion, "5K")
	elif Input.is_action_pressed("down%s" % [playerIndex]):
		pass
	# Move the character
	self.velocity = velocity
	move_and_slide()
	
	if neutral:
		buffer.inputGrab("5")
	
func playAttack(motion, atk):
	neutral = false
	if motion == null:
		$AnimationPlayer.play(atk)
	else:
		$AnimationPlayer.play(motion)
		print("You can now do special inputs")
		print(motion)
		#make it flip if player is flipped
