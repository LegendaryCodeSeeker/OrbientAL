extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _find_level_type(dir):
	var Level = FileAccess.open(dir, FileAccess.READ)
	var LL = Level.get_length() / 16
	Level.close()
	if (LL % 2 == 0):
		print("this is an orbient level")
		_process_OLD(dir)
	else:
		print("this is an astronomical leap level (WARNING not currently implamented)")
		_process_ALLD(dir)

func _process_OLD(dir):
	print("file path: ", dir)
	
	var _data = FileAccess.get_file_as_bytes(dir)
	var _sig0 = _data.slice(0, 8)
	var _sig1 = _data.slice(28, 32)
	var _levelWidth = _data.slice(8, 12)
	var _levelHeight = _data.slice(12, 16)
	var _levelDate = _data.slice(16, 24)
	var _objectCount = _data.slice(24, 28)
	
	_levelWidth.reverse()
	_levelWidth = _levelWidth.decode_float(0)
	_levelHeight.reverse()
	_levelHeight = _levelHeight.decode_float(0)
	_levelDate.reverse()
	_levelDate = _levelDate.decode_u64(0)
	_levelDate = Time.get_datetime_dict_from_unix_time(_levelDate)
	_objectCount.reverse()
	_objectCount = _objectCount.decode_u32(0)
	
	print("Signature: ", _sig0, ", ", _sig1)
	print("level width: ", _levelWidth)
	print("level height: ", _levelHeight)
	print("creation: ", _levelDate)
	print("objects: ", _objectCount)
	
	_iterate_Objects(_objectCount, _data, 0)
	

func _process_ALLD(dir):
	print("file path", dir)

func _iterate_Objects(Count, data, idt):
	var obj
	var a
	
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
	var ORBIT
	var TYPE
	#endregion
	
	for i in Count:
		a = 32*i
		obj = data.slice(32+a, 64+a)
		
		#region SLICER
		ID = obj.slice(0, 1)
		TYPE = obj.slice(1, 2)
		OBID = obj.slice(2, 3)
		ORBIT = obj.slice(3, 4)
		APX = obj.slice(4, 8)
		APY = obj.slice(8, 12)
		SIZE = obj.slice(12, 16)
		ANGLE = obj.slice(16, 20)
		SPEED = obj.slice(20, 24)
		RPX = obj.slice(24, 28)
		RPY = obj.slice(28)
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
		ORBIT = ORBIT.decode_s8(0)
		APX = APX.decode_float(0)
		APY = APY.decode_float(0)
		SIZE = floor(SIZE.decode_float(0) / 25.0)
		ANGLE = ANGLE.decode_float(0)
		SPEED = SPEED.decode_float(0)
		RPX = RPX.decode_float(0)
		RPY = RPY.decode_float(0)
		#endregion
		
		print("Object: ", i+1, "\n  Id: ", ID, "\n  Type: ", TYPE, "\n  Orbiting Id: ", OBID, "\n  Orbit speed: ", ORBIT, "\n  Position: (x: ", APX, ", y: ", APY, ")\n  Size: ", SIZE, "\n  Angle: ", ANGLE, "\n  Velocity: ", SPEED, "\n  Orbiting position: (x: ", RPX, ", y: ", RPY, ")\n")
