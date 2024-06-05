extends Node

func Find_Level_Type(_Dir):
	var Level = FileAccess.open(_Dir, FileAccess.READ)
	var LL = Level.get_length() % 16
	
	if (LL != 0):
		Level.close()
		return(12)
		
	LL = Level.get_length() / 16
	Level.close()
	
	if (LL % 2 == 0):
		Process_OLD(_Dir)
	else:
		print("this is an astronomical leap level (WARNING not currently implamented)")
		Process_ALLD(_Dir)

func Process_OLD(_Dir):
	
	var Data = FileAccess.get_file_as_bytes(_Dir)
	
	#region SLICER
	var Sig0 = Data.slice(0, 8)
	var Sig1 = Data.slice(28, 32)
	var Level_width = Data.slice(8, 12)
	var Level_height = Data.slice(12, 16)
	var Level_date = Data.slice(16, 24)
	var Object_count = Data.slice(24, 28)
	#endregion
	
	#region REVERSER
	Level_width.reverse()
	Level_height.reverse()
	Level_date.reverse()
	Object_count.reverse()
	#endregion
	
	#region DECODER
	Sig0 = Sig0.get_string_from_ascii()
	Sig1 = Sig1.get_string_from_ascii()
	Level_width = Level_width.decode_float(0)
	Level_height = Level_height.decode_float(0)
	Level_date = Level_date.decode_u64(0)
	Level_date = Time.get_datetime_dict_from_unix_time(Level_date)
	Object_count = Object_count.decode_u32(0)
	#endregion
	
	print("\nSignature: ", Sig0, ", ", Sig1)
	print("level (width: ", Level_width, ", height: ", Level_height, ")")
	print("creation: ", Level_date.day, "/", Level_date.month, "/", Level_date.year, " at ", Level_date.hour, ":", Level_date.minute, ":", Level_date.second)
	print("objects: ", Object_count, "\n")
	
	Iterate_Objects(Object_count, Data, 0)

func Process_ALLD(_Dir):
	print("file path", _Dir)

func Iterate_Objects(_Count, _Data, _IDT):
	#breakpoint
	var Obj
	var Parameters
	var Scrpt = load("res://assets/scripts/Object_handler.gd")
	
	#region Object variables
	var ID
	var OBID
	var APX
	var APY
	var RPX
	var RPY
	var SIZE
	var ANGLE
	var SPEED
	var STEP
	var TYPE
	#endregion
	
	print("iterating")
	
	for i in _Count:
		Obj = _Data.slice(32+(32*i), 64+(32*i))
		
		#region SLICER
		ID = Obj.slice(0, 1)
		TYPE = Obj.slice(1, 2)
		OBID = Obj.slice(2, 3)
		STEP = Obj.slice(3, 4)
		APX = Obj.slice(4, 8)
		APY = Obj.slice(8, 12)
		SIZE = Obj.slice(12, 16)
		ANGLE = Obj.slice(16, 20)
		SPEED = Obj.slice(20, 24)
		RPX = Obj.slice(24, 28)
		RPY = Obj.slice(28)
		#endregion
		
		#region REVERSER
		APX.reverse()
		APY.reverse()
		SIZE.reverse()
		ANGLE.reverse()
		SPEED.reverse()
		RPX.reverse()
		RPY.reverse()
		#endregion
		
		#region DECODER
		ID = ID.decode_u8(0)
		TYPE = TYPE.decode_u8(0)
		OBID = OBID.decode_u8(0)
		STEP = STEP.decode_s8(0)
		APX = APX.decode_float(0)
		APY = APY.decode_float(0)
		SIZE = SIZE.decode_float(0)
		ANGLE = ANGLE.decode_float(0)
		SPEED = SPEED.decode_float(0)
		RPX = RPX.decode_float(0)
		RPY = RPY.decode_float(0)
		#endregion
		
		Parameters = [ID,TYPE,OBID,STEP,SIZE,ANGLE,SPEED,APX,APY,RPX,RPY]
		#breakpoint
		$"..".add_child(Scrpt.Object_instancer._create(Parameters))
		
		print("Object: ", i+1, "\n{\n Id: ", ID, "\n Type: ", TYPE, "\n Orbiting Id: ", OBID, "\n Velocity Step: ", STEP, "\n Position: (x: ", APX, ", y: ", APY, ")\n Size: ", SIZE, "\n Angle: ", ANGLE, "\n Velocity: ", SPEED, "\n Orbiting position: (x: ", RPX, ", y: ", RPY, ")\n}\n")
		

