extends Node
class_name replayRecord

var frame = []

func recordStates(State, input):
	frame.append([State,input])
	#this creates giant list of character states that can be recorded into a json file for replays
	
	
func DashCheck() -> bool:
	if frame.size() < 2:
		return false

	# Get last 15 states (or less if not enough)
	var window = frame.slice(max(frame.size() - 30, 0), frame.size())

	# Extract only the state names
	var states = []
	for item in window:
		states.append(item[0])

	# Find first Forward
	var first_forward_index = states.find("Forward")
	if first_forward_index == -1:
		return false

	# Look for second Forward after first
	for i in range(first_forward_index + 1, states.size()):
		if states[i] == "Forward":
			# Check how many Idle states are between
			var between = states.slice(first_forward_index + 1, i)
			var idle_count = 0
			for s in between:
				if s == "Idle":
					idle_count += 1

			if idle_count >= 3:
				return true  # Valid dash
			else:
				return false  # Not enough Idle frames

	return false



#func DashCheck():
#	var last15 = frame.slice(-15 ,frame.size()-5)
#	var holdframes = ["","","","",""]
#	for x in last15:
#		if "Forward" in last15 && holdframes[0] == "":
#			holdframes[0] = "Forward"
#		elif frame[frame.size()-4 ][0] == "Idle" && holdframes[1] == "":
#			holdframes[1] = "Idle"
#		elif frame[frame.size()-3 ][0]== "Idle" && holdframes[2] == "":
#			holdframes[2] = "Idle"
#		elif frame[frame.size()-2 ][0] == "Idle" && holdframes[3] == "":
#			holdframes[3] = "Idle"
#		elif frame[frame.size()-1][0] == "Forward" && holdframes[3] == "":
#			holdframes[4]= "Forward"
#	print(last15)
#	if holdframes == ["Forward", "Idle","Idle", "Idle", "Forward"]:
#		return true
#	else:
#		return false
