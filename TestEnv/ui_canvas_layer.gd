extends CanvasLayer
@onready var p1HealthBar = $healthPlayer1
@onready var p2HealthBar = $healthPlayer2



func _ready() -> void:
	pass

func updateInfo(p1_health, p2_health):
	p1HealthBar.health = p1_health
	p2HealthBar.health = p2_health

	
func init_ui(p1_health, p2_health):
	p1HealthBar.init_health(p1_health)
	p2HealthBar.init_health(2000)
