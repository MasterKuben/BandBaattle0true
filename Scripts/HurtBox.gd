class_name HurtBox
extends Area2D

func setColl() -> void:
	if owner.entType == "enemy":
		collision_layer = 0
		collision_mask = 2
	elif owner.entType == "player0":
		collision_layer = 128
		collision_mask = 4

func _ready() -> void:
	setColl()
	connect("area_entered", self._on_area_entered)
	
func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return
	else:
		print("hit")
		print(hitbox.damage)
	if owner.has_method("takeDamage"):
		owner.takeDamage(hitbox.damage)
