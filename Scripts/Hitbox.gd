class_name HitBox
extends Area2D

@export var damage: int = 0
@onready var character := get_parent().get_parent()

func setColl() -> void:
	if character.is_in_group("enemy"):
		collision_layer = 2
		collision_mask = 128
	elif character.is_in_group("player1hithurt"):
		collision_layer = 2
		collision_mask = 0

func _ready() -> void:
	print("HitBox parent:", get_parent())
	print("HitBox grandparent:", get_parent().get_parent())
	setColl()
	var charName = character.name
	var atkName = self.name
	var atk = attackInfo.new()
	damage = atk.attackDam(charName, atkName)
	print(atkName)
	print(damage)
