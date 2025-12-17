class_name HurtBox
extends Area2D

func setColl() -> void:
	if owner.is_in_group("enemy"):
		collision_layer = 0 #layer for hurtbox
		collision_mask = 2 #layer to dectet hitbox
	elif owner.is_in_group("player1hithurt"):
		collision_layer = 128#these are the layers for the hurtbox
		collision_mask = 4#this is the layer a hurtbox to be detected
		print("2")
		print("a")

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
