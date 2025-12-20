extends Node

@onready var p1HealthBar = $healthPlayer1
@onready var p2HealthBar = $healthPlayer2
@onready var p1Health = $CharacterStates/TestMan.health
@onready var uiElements = $UICanvasLayer

func _ready() -> void:
	uiElements.init_ui(p1Health, 2000)

func _physics_process(delta: float) -> void:
	uiElements.updateInfo($CharacterStates/TestMan.health, 2000)
	
func _init(player1in, player2in) -> void:
	pass
	#make it give player 1 and 2 their indexes
	#make it load stage background

func setPlayerChars(p1CharName, p2CharName):#this is meant to grab selected characters from a file for a scene
	pass
