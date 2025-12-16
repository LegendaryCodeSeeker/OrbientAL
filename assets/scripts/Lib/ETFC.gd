class Local_Endian_Check:
	
	const Dir := "res://assets/data/"
	const Names := ["3e.2s","1r.f0"]
	var Name = Names[randi_range(0,Names.size()-1)]
	var CTR := 0
	var FC := []
	var CL := []
	var Answers := []
	var File
	var SHUTDOWN := false
	
	func _Load():
		if Name.length() != 5:
			#TODO add Error popup and a wait timer to close the game/button press
			SHUTDOWN = true
			return
		File = FileAccess.get_file_as_bytes(Dir+Name)
		CTR = File.slice(0,-1).decode_u8(0) #get last byte, the "Checks To Run" Byte
		FC = File.slice(-1,-5)
		for i in CTR:
			CL.append(File.slice(-6-i,-7-i))
	
	func _Check(_Num):
		pass
	
	func _process(_delta: float) -> void:
		Run()
	
	func Run():
		_Load()
		if SHUTDOWN == true:
			CTR = 1/randi_range(0,0)
