extends Node

#parameters = [ID,TYPE,OBID,STEP,SIZE,ANGLE,SPEED,APX,APY,RPX,RPY]
func _create_Instance(param):
	var Sphere = preload("res://assets/models/TEST_SPHERE.obj")
	var ojid = str(param[1], param[0])
	var object = MeshInstance3D.new()
	var pos = Vector3(0,0,0)
	
	print("Creating Instance: ", ojid)
	
	if (param[2] != 255):
		pos = Vector3(param[7], param[8], 0)
	else:
		pos = Vector3(param[9], param[10], 0)
	
	object.set_name(ojid)
	object.set_position(pos)
	object.set_mesh(Sphere)
