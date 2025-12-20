extends ProgressBar

@onready var timer = $Timer
@onready var damageBar = $damage

var health = 0 : set = _set_health

func _set_health(new_health):
	var prevHealth = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
	if health < prevHealth:
		timer.start()
	else:
		damageBar.value = health

func init_health(_health):
	health = _health
	max_value = _health
	value = _health
	damageBar.max_value = health
	damageBar.value = health
	


func _on_timer_timeout() -> void:
	damageBar.value = health
