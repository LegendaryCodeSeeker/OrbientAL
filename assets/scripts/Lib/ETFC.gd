class Local_Endian_Check:
	
	const Dir := "res://assets/data/"
	const Names := ["3e.2s","1r.f0"]
	var Name = Names[randi_range(0,Names.size()-1)]
	var CTR := 0
	var FC := []
	var CL := []
	var Questions := []
	var Answers := []
	var File
	var SHUTDOWN := false
	var SDR := -1
	var ES := 0
	
	func _Load():
		
		#region errChck00									#Checks to see if the File attempting to be loaded is a 4C.F (4 Character Dot File) and that its name is formatted right.
		if Name.length() != 5 || Name.findn(".") != 2:
			SDR = 0
			printerr("Not In 4C.FF")
			_Shut()
		#endregion
		
		File = FileAccess.get_file_as_bytes(Dir+Name)		#Opens Valid File as a Byte List
		CTR = File.slice(0,-1).decode_u8(0) 				#get last byte, the "Checks To Run" Byte
		FC = File.slice(-1,-5)								#get First Check Bytes should be 00 01 02 03 04
		
		#region errChck01									#Run the Fist Check to see if it matches known possible values.
		if FC != [00,01,02,03,04] || [04,03,02,01,00]:
			SDR = 1
			printerr("File Not Correct: " + str(FC))
			_Shut()
		elif FC == [04,03,02,01,00]:						#If 2nd Possible Value Then Run This
			#TODO Find a way to revert whatever is going on here during this step and replace the following code \/.
			printerr("File Not Reading Correctly: 43210")
			return
		#endregion
		
		for i in CTR:
			CL.append(File.slice(-6-i,-7-i).decode_u8(0))	#get Checks Lengths Based on Checks To Run Counter
		CL.reverse()
		
		#region errChck02									#Checks If Expected Check Total Size Is Larger then File Size
		for j in CL.size():									#Calculates Expected Total Checks Size
			ES += (CL[j]+1)
		
		if ES > File.size():
			SDR = 2
			printerr("Expected Sizes Total Too Big: " + str(ES) + " Bytes")
			printerr("File Size: " + str(File.size()) + " Bytes")
			_Shut()
		#endregion
		
		
	
	func _Shut():
		var _Value
		#TODO add Error popup and a wait timer to close the game/button press
		printerr("Error: " + str(SDR))
		Engine.get_main_loop().finish()
	
	func _Check(_Answer,_Question):
		pass
	
	func _process(_delta: float) -> void:
		Run()
	
	func Run():
		_Load()
