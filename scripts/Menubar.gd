extends Control
# Called when the node enters the scene tree for the first time.

#region VARIABLES
@onready var Godot = true #debugging var
#endregion

#region .NEW()
@onready var SMenuObject = PopupMenu.new()
@onready var SsMenuTrans = PopupMenu.new()
@onready var SsMenuScale = PopupMenu.new()
@onready var SsMenuType = OptionButton.new()
@onready var SMenuMode = PopupMenu.new()
@onready var SsMenuSpec = PopupMenu.new()
@onready var SsMenuSim = PopupMenu.new()
#endregion

#region SHORTPATH
@onready var MenuFile = $MenuBar/HBoxContainer/File
@onready var MenuEdit = $MenuBar/HBoxContainer/Edit
@onready var MenuView = $MenuBar/HBoxContainer/View
@onready var MenuOptions = $MenuBar/HBoxContainer/Options
#endregion

func _ready():
	
	_MenuBar()#handles menu bar init doing it in code because thats what the tutorials show lol
	
	MenuFile.get_popup().connect("id_pressed", _on_File_item_pressed)
	MenuEdit.get_popup().connect("id_pressed", _on_Edit_item_pressed)
	MenuView.get_popup().connect("id_pressed", _on_View_item_pressed)
	MenuOptions.get_popup().connect("id_pressed", _on_Opt_item_pressed)
	
	#$MenuBar/HBoxContainer/Edit/Object.get_popup().connect("id_pressed", _on_Object_Smenu_Edit_pressed)

func _on_File_item_pressed(id):
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

func _on_View_item_pressed(_id):
	pass
	
func _on_Opt_item_pressed(_id):
	pass
	
func _on_Object_Smenu_Edit_pressed(id):
	if (Godot == true): print(id, " Edit/Object Menu Child")
	
func _MenuBar():
	
	#region EDIT
	#adds the Options to the Edit button
	
	#region OBJECT
	#adds the Options to the Object Submenu
	SMenuObject.set_name("Object")
	SMenuObject.add_item(" ")
	SMenuObject.set_item_disabled(0, true) #ugly workaround for Edit/Object/Type options item because im still learning i know but if it works it works
	SMenuObject.add_item("Angle")
	SMenuObject.add_item("Velocity")
	
	#region TRANSFORM
	#adds Trasnform SubSubMenu
	SsMenuTrans.set_name("Transform")
	SsMenuTrans.add_item("Free")
	SsMenuTrans.add_item("X")
	SsMenuTrans.add_item("Y")
	SsMenuTrans.set_item_disabled(1, true)
	SsMenuTrans.set_item_disabled(2, true)
	#endregion
	
	#region SCALE
	#adds Scale SubSubMenu
	SsMenuScale.set_name("Scale")
	SsMenuScale.add_item("Uniform")
	SsMenuScale.add_item("X")
	SsMenuScale.add_item("Y")
	SsMenuScale.set_item_disabled(1, true)
	SsMenuScale.set_item_disabled(2, true)
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
	
	SMenuObject.add_child(SsMenuTrans) #
	SMenuObject.add_child(SsMenuScale)
	SMenuObject.add_child(SsMenuType)
	SMenuObject.add_submenu_item("Transform","Transform")
	SMenuObject.add_submenu_item("Scale","Scale")
	#endregion
	
	#endregion
	
	#region VIEW
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
	#endregion

func _on_load_file_selected(path):
	var Level_interpreter = preload("res://scripts/Level_interpreter.gd")
	var LI = Level_interpreter.new()
	var Level = LI._find_level_type(path)
	if (Level == 12):
		$ErrorPop.popup()
