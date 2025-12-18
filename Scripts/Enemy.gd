extends CharacterBody2D

@onready var healthbar = $healthbar
var health
@export var entType:String = "enemy"

func _ready() -> void:
	health = 1000
	healthbar._init_health(health)

func takeDamage(atkDam) -> void:
	if health > 0 && atkDam < health:
		health = health - atkDam
		print(health)
	
	elif health > 0:
		health = 0
	elif health <= 0:
		print("Already dead")
	healthbar.health = health
	
	
func _process(delta: float) -> void:
		pass
