extends Node

#parameters = [ID,TYPE,OBID,STEP,SIZE,ANGLE,SPEED,APX,APY,RPX,RPY]
func _on_level_ready():
	pass # Replace with function body

func _create_Instance(param):
	var Sphere = SphereMesh.new()
	var sig0
	var sig1
	var object = MeshInstance3D.new()
	var pos = Vector3(param[7],param[8],0)
	var size = (param[4] + 2) / 20.0 + 3
	
	#region 00x 0xx xxx
	if(param[0] < 10):
		sig0 = str("00",param[0])
	elif(param[0] < 100):
		sig0 = str("0",param[0])
	else:
		sig0 = str(param[0])
	
	if(param[1] < 10):
		sig1 = str("00",param[1])
	elif(param[1] < 100):
		sig1 = str("0",param[1])
	else:
		sig1 = str(param[1])
	#endregion
	
	var ojid = str(sig1,sig0)
	
	print("Creating Instance: ", ojid)
	
	#if (param[2] != 255):
	#	pos = Vector3(param[7], param[8], 0)
	#else:
	#	pos = Vector3(param[9], param[10], 0)
	
	object.set_name(ojid)
	object.set_position(pos)
	Sphere.set_radius(size/3.0)
	Sphere.set_height(size/1.5)
	object.set_mesh(Sphere)
	var lvl = get_node("../..")
	print("path: ", lvl)
	#breakpoint
	lvl.add_child(object)
	print_orphan_nodes()
