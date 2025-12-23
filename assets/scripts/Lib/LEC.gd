extends Node

func _ready():
	Run()
	#TODO Remove this WHOLE function after testing so this script can be called by it self not relying on a node.

var LTypes = [[2],[0,0]]

const Dir := "res://assets/data/"
const Names := ["3e.2s","1r.f0"]
var Name
var CTR := 0
var FC := []
var CL := []
var Questions := []
var Answers := []
var File
var SDR := -1
var ES := 0

func _Load():
	
	var a = 0
	var b = 0
	var c = 0
	Name = Names[randi_range(0,Names.size()-1)]
	
	#region errChck00										#Checks to see if the File attempting to be loaded is a 4C.F (4 Character Dot File) and that its name is formatted right.
	if Name.length() != 5 || Name.findn(".") != 2 || Name.count(".") != 1:
		SDR = 0
		printerr("Not In 4C.FF")
		_Shut()
	else:
		print_rich("[color=green][b]{•}--[/b] Is In 4C.FF[/color]")
	#endregion
	
	File = FileAccess.get_file_as_bytes(Dir+Name)			#Opens Valid File as a Byte List
	var FS = File.size()
	CTR = (File.slice(FS-1,FS).decode_u8(0))+1				#get last byte, the "Checks To Run" Byte
	for l in 5:
		FC.append(File.slice(FS-2-l,FS-1-l).decode_u8(0))	#get First Check Bytes should be 00 01 02 03 04
	FC.reverse()
	
	#region errChck01										#Run the Fist Check to see if it matches known possible values.
	if (FC != [0,1,2,3,4]) && (FC != [4,3,2,1,0]):
		SDR = 1
		printerr("File Not Correct: " + str(FC))
		_Shut()
	elif FC == [4,3,2,1,0]:									#If 2nd Possible Value Then Run This
		#TODO Find a way to revert whatever is going on here during this step and replace the following code \/.
		printerr("File Not Reading Correctly: 43210")
		return
	else:
		print_rich("[color=green][b]{••}-[/b] Passed First Check[/color]")
	#endregion
	
	for i in CTR:
		c = FS-7-i
		CL.append((File.slice(c,FS-6-i).decode_u8(0))+1)#get Checks Lengths Based on Checks To Run Counter
	
	#region errChck02										#Checks If Expected Check Total Size Is Larger then File Size
	for j in CL.size():										#Calculates Expected Total Checks Size
		ES += (CL[j]+1)
	
	if ES > FS:
		SDR = 2
		printerr("Expected Sizes Total Too Big: " + str(ES) + " Bytes")
		printerr("File Size: " + str(FS) + " Bytes")
		_Shut()
	else:
		print_rich("[color=green][b]{•••}[/b] Passed Second Check[/color]")
	#endregion
	breakpoint
	for k in CL.size():										#add Check Lengths to a list along side the "questions"
		if k == 0:
			b += CL[k]
		else:
			a += CL[k-1]
			b += CL[k]
		Questions.append([File.slice(a,b),CL[k]])
		
	
	print(File.slice(b,c))

func _Shut():
	var _Value
	#TODO add Error popup and a wait timer to close the game/button press
	printerr("Error: " + str(SDR))
	Engine.get_main_loop().quit()


func _Check(_Answer,_Question):
	pass

func Run():
	_Load()
