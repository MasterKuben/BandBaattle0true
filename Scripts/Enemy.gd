extends CharacterBody2D

var health = 1000
@export var entType:String = "enemy"

func takeDamage(atkDam) -> void:
	if health > 0 && atkDam < health:
		health = health - atkDam
		print(health)
	elif health > 0:
		health = 0
	elif health <= 0:
		print("Already dead")
	
	
func _process(delta: float) -> void:
		pass
