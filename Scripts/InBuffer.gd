class_name inputBuffer #This script is for making motion inputs in the game
extends Node
var lastInputs = ["5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5","5"]#These are the last 20 inputs in the last 20 frames
@export var motionPut = []
var motionList = ["623P","623K","623I","623S","236K"]#Make this based on the chars list of inputs that they can have


func motionGet():
	for x in motionList:
		var motionPut = []
		var inputNode = 0
		var motionComp = x.split("")
		#print(motionComp)
		for y in lastInputs:
			if y == motionComp[inputNode]:
				print(x[inputNode])
				motionPut.append(x[inputNode])
				inputNode += 1
			if inputNode == x.length():
				var motion = "".join(motionPut)
				lastInputs = ["5","5","5","5","5","5","5","5","5","5","5","5","5","5","5", "5", "5", "5","5","5", "5", "5", "5"]
				print(motion)
				return motion
	return null

func inputGrab(inVal) -> void:
	lastInputs.remove_at(0)
	lastInputs.append(inVal)
	print(lastInputs)
	print(1)
	
