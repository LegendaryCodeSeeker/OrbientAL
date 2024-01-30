extends Control
# Called when the node enters the scene tree for the first time.

#region VARIABLES
@onready var Godot = true
#endregion

#region .NEW()
@onready var SMenuObject = PopupMenu.new()
@onready var SsMenuTrans = PopupMenu.new()
@onready var SsMenuScale = PopupMenu.new()
@onready var SsMenuType = OptionButton.new()
@onready var SMenuMode = PopupMenu.new()
@onready var SsMenuSpec = PopupMenu.new()
@onready var SsMenuSim = PopupMenu.new()
@onready var VBC = VBoxContainer.new()
@onready var BCbox = CheckBox.new()
@onready var AVbox = CheckBox.new()
@onready var GEbox = CheckBox.new()
@onready var LBbox = CheckBox.new()
#endregion

#region SHORTPATHS
@onready var MenuFile = $MenuBar/HBoxContainer/File
@onready var MenuEdit = $MenuBar/HBoxContainer/Edit
@onready var MenuView = $MenuBar/HBoxContainer/View
@onready var MenuOptions = $MenuBar/HBoxContainer/Options
#endregion

func _ready():
	_MenuBar()

func _on_File_item_pressed(id):
	if (Godot == true): print(id, " File Menu Child")
	if id == 1:
		$MenuBar/HBoxContainer/File/Load.popup()
		if (Godot == true): print("Load")
		
	elif id == 2:
		$MenuBar/HBoxContainer/File/Save.popup()
		if (Godot == true): print("Save")
	elif id == 0:
		$MenuBar/HBoxContainer/File/New.popup()
		if (Godot == true): print("New")
	else:
		if (Godot == true): print("WEEEEEEEEEEEEE")
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		get_tree().quit()

func _on_Edit_item_pressed(id):
	if (Godot == true): print(id, " Edit Menu Child")

func _on_Object_Smenu_Edit_pressed(id):
	if (Godot == true): print(id, " Edit/Object Menu Child")
	
func _MenuBar():
	
	#region FILE
	#adds the Options to the File button
	MenuFile.get_popup().add_item("New")
	MenuFile.get_popup().add_item("Load")
	MenuFile.get_popup().add_item("Save")
	MenuFile.get_popup().add_item("Quit")
	#endregion
	
	#region EDIT
	#adds the Options to the Edit button
	MenuEdit.get_popup().add_item("Undo")
	MenuEdit.get_popup().add_item("Redo")
	MenuEdit.get_popup().add_item("Copy")
	MenuEdit.get_popup().add_item("Paste")
	
	#region OBJECT
	#adds the Options to the Object Submenu
	SMenuObject.set_name("Object")
	SMenuObject.add_item(" ") #ugly workaround for Edit/Object/Type options item because im still learning i know but if it works it works
	SMenuObject.add_item("Angle")
	SMenuObject.add_item("Velocity")
	
	#region TRANSFORM
	#adds Trasnform SubSubMenu
	SsMenuTrans.set_name("Transform")
	SsMenuTrans.add_item("Free")
	SsMenuTrans.add_item("X")
	SsMenuTrans.add_item("Y")
	#endregion
	
	#region SCALE
	#adds Scale SubSubMenu
	SsMenuScale.set_name("Scale")
	SsMenuScale.add_item("Uniform")
	SsMenuScale.add_item("X")
	SsMenuScale.add_item("Y")
	#endregion
	
	#region TYPE
	#adds the Type Option button
	SsMenuType.set_name("Type")
	SsMenuType.add_item("Player")
	SsMenuType.add_item("Star")
	SsMenuType.add_item("Goal")
	SsMenuType.add_item("Astroid")
	SsMenuType.add_item("Moon")
	SsMenuType.add_item("Barycenter")
	SsMenuType.add_item("Black Hole")
	#endregion
	
	MenuEdit.get_popup().add_child(SMenuObject, true) #adds Object as a child of the Edit Menu
	MenuEdit.get_popup().add_submenu_item("Object","Object") #adds the button for the Object Submenu and its popup menu
	
	if (Godot == true): print(MenuEdit.get_child_count(), " Edit Menu Child Count")
	
	SMenuObject.add_child(SsMenuTrans) #
	SMenuObject.add_child(SsMenuScale)
	SMenuObject.add_child(SsMenuType)
	SMenuObject.add_submenu_item("Transform","Transform")
	SMenuObject.add_submenu_item("Scale","Scale")
	#endregion
	
	MenuEdit.get_popup().add_item("Create")
	MenuEdit.get_popup().add_item("Delete")
	#endregion
	
	#region VIEW
	
	MenuView.get_popup().add_item("                                        |")
	MenuView.get_popup().add_item("                                        |")
	MenuView.get_popup().add_item("                                        |")
	MenuView.get_popup().add_item("                                        |")
	
	#region MODE
	SMenuMode.set_name("Mode")
	SMenuMode.add_item("Edit")
	MenuView.get_popup().add_child(SMenuMode)
	MenuView.get_popup().add_submenu_item("Mode","Mode")
	
	#region SPECTATE
	SsMenuSpec.set_name("Spectate")
	SsMenuSpec.add_item("Original")
	SsMenuSpec.add_item("Astronomical Leap")
	SMenuMode.add_child(SsMenuSpec)
	SMenuMode.add_submenu_item("Spectate","Spectate")
	#endregion
	
	#region SIMULATE
	SsMenuSim.set_name("Simulate")
	SsMenuSim.add_item("Original")
	SsMenuSim.add_item("Astronomical Leap")
	SMenuMode.add_child(SsMenuSim)
	SMenuMode.add_submenu_item("Simulate","Simulate")
	#endregion
	
	#endregion
	
	var BCString = " Show Barycenters"
	var AVString = " Show Angles and Velocities"
	var GEString = " Show Gravitational Affectors"
	var LBString = " Show Level Bounds"
	
	var BC = Label.new()
	var AV = Label.new()
	var GE = Label.new()
	var LB = Label.new()
	BC.text = BCString
	AV.text = AVString
	GE.text = GEString
	LB.text = LBString
	
	VBC.set_name("VBC")
	MenuView.get_popup().add_child(VBC)
	BCbox.set_name(BCString)
	BCbox.text = BCString
	VBC.add_child(BCbox)
	AVbox.set_name(AVString)
	VBC.add_child(AVbox)
	GEbox.set_name(GEString)
	VBC.add_child(GEbox)
	LBbox.set_name(LBString)
	VBC.add_child(LBbox)
	
	#endregion
	
	MenuFile.get_popup().connect("id_pressed", _on_File_item_pressed)
	MenuEdit.get_popup().connect("id_pressed", _on_Edit_item_pressed)
	
	#$MenuBar/HBoxContainer/Edit/Object.get_popup().connect("id_pressed", _on_Object_Smenu_Edit_pressed)
