class Object_instancer:
	 
	
	static func _create(_Param):
		var Sphere = SphereMesh.new()
		var Sig0
		var Sig1
		var Obj = MeshInstance3D.new()
		var POS = Vector3(_Param[7],_Param[8],0)
		var Size = _Param[4]
		var scale = 0.0234375
		var Sizer = Size/2
		var Sizeh = Size
		
		#region 00x 0xx xxx
		if(_Param[0] < 10):
			Sig0 = str("00",_Param[0])
		elif(_Param[0] < 100):
			Sig0 = str("0",_Param[0])
		else:
			Sig0 = str(_Param[0])
		
		if(_Param[1] < 10):
			Sig1 = str("00",_Param[1])
		elif(_Param[1] < 100):
			Sig1 = str("0",_Param[1])
		else:
			Sig1 = str(_Param[1])
		#endregion
		
		var OJID = str(Sig1,Sig0)
		
		print("Creating Instance: ", OJID)
		
		#if (_Param[2] != 255):
			#POS = Vector3(_Param[7], _Param[8], 0)
		#else:
			#POS = Vector3(_Param[9], _Param[10], 0)
		
		Obj.set_name(OJID)
		Obj.set_position(POS)
		Sphere.set_radius(Sizer*0.5)
		Sphere.set_height(Sizeh*0.5)
		Obj.set_mesh(Sphere)
		return(Obj)

class Object_eraser:
	func _erase(_Mode, _Level, _To_erase):
		if (_Mode == 0):#erase all
			pass
