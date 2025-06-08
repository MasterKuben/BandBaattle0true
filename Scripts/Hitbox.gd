class_name HitBox
extends Area2D

@export var damage: int = 0


func setColl() -> void:
	if owner.entType == "enemy":
		collision_layer = 2
		collision_mask = 128
	elif owner.entType == "player0":
		collision_layer = 2
		collision_mask = 0

func _ready() -> void:
	setColl()
	var charName = owner.name
	var atkName = get_parent().name
	var atk = attackInfo.new()
	damage = atk.attackDam(charName, atkName)
	print(atkName)
	print(damage)
