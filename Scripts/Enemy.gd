extends CharacterBody2D

@onready var healthbar = $healthbar
var health
@export var entType:String = "enemy"

func _ready() -> void:
	health = 1000
	healthbar.init_health(health)

func takeDamage(atkDam, atkStun) -> void:
	if health > 0 && atkDam < health:
		health = health - atkDam
		if atkStun <= 2:
			$AnimationPlayer.play("HitStun")#this just checks if hitstun is correctly recieved
		print(health)
	
	elif health > 0:
		health = 0
	elif health <= 0:
		print("Already dead")
	healthbar.health = health
	
	
func _process(delta: float) -> void:
		pass
