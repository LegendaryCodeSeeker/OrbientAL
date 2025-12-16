extends Node

#For Functions that can be re-used in multiple scenes and scripts 

func Clear_Level_Objects(level_path):
	if !str(level_path).contains("Level"):
		return 								#Exit if attempting to run outside of Level node
	for i in level_path.get_child_count():
		if (i > 1):
			level_path.get_child(2).free() 	#Remove all but the camera and light might make it recenter the camera later
