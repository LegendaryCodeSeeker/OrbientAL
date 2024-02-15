extends Control
# Called when the node enters the scene tree for the first time.

#region VARIABLES
@onready var Godot = true #debugging var
#endregion

#region .NEW()
@onready var S_menu_object = PopupMenu.new()
@onready var Ss_menu_trans = PopupMenu.new()
@onready var Ss_menu_scale = PopupMenu.new()
@onready var Ss_menu_type = OptionButton.new()
@onready var S_menu_mode = PopupMenu.new()
@onready var Ss_menu_spec = PopupMenu.new()
@onready var Ss_menu_sim = PopupMenu.new()
#endregion

#region SHORTPATH
@onready var Menu_file = $MenuBar/HBoxContainer/File
@onready var Menu_edit = $MenuBar/HBoxContainer/Edit
@onready var Menu_view = $MenuBar/HBoxContainer/View
@onready var Menu_options = $MenuBar/HBoxContainer/Options
#endregion

func _ready():
	
	Menu_Bar()#handles menu bar init doing it in code because thats what the tutorials show lol
	
	Menu_file.get_popup().connect("id_pressed", _on_File_item_pressed)
	Menu_edit.get_popup().connect("id_pressed", _on_Edit_item_pressed)
	Menu_view.get_popup().connect("id_pressed", _on_View_item_pressed)
	Menu_options.get_popup().connect("id_pressed", _on_Opt_item_pressed)
	
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
	
func Menu_Bar():
	
	#region EDIT
	#adds the Options to the Edit button
	
	#region OBJECT
	#adds the Options to the Object Submenu
	S_menu_object.set_name("Object")
	S_menu_object.add_item(" ")
	S_menu_object.set_item_disabled(0, true) #ugly workaround for Edit/Object/Type options item because im still learning i know but if it works it works
	S_menu_object.add_item("Angle")
	S_menu_object.add_item("Velocity")
	
	#region TRANSFORM
	#adds Trasnform SubSubMenu
	Ss_menu_trans.set_name("Transform")
	Ss_menu_trans.add_item("Free")
	Ss_menu_trans.add_item("X")
	Ss_menu_trans.add_item("Y")
	Ss_menu_trans.set_item_disabled(1, true)
	Ss_menu_trans.set_item_disabled(2, true)
	#endregion
	
	#region SCALE
	#adds Scale SubSubMenu
	Ss_menu_scale.set_name("Scale")
	Ss_menu_scale.add_item("Uniform")
	Ss_menu_scale.add_item("X")
	Ss_menu_scale.add_item("Y")
	Ss_menu_scale.set_item_disabled(1, true)
	Ss_menu_scale.set_item_disabled(2, true)
	#endregion
	
	#region TYPE
	#adds the Type Option button
	Ss_menu_type.set_name("Type")
	Ss_menu_type.add_item("Player")
	Ss_menu_type.add_item("Star")
	Ss_menu_type.add_item("Goal")
	Ss_menu_type.add_item("Astroid")
	Ss_menu_type.add_item("Moon")
	Ss_menu_type.add_item("Barycenter")
	Ss_menu_type.add_item("Black Hole")
	#endregion
	
	Menu_edit.get_popup().add_child(S_menu_object, true) #adds Object as a child of the Edit Menu
	Menu_edit.get_popup().add_submenu_item("Object","Object") #adds the button for the Object Submenu and its popup menu
	
	S_menu_object.add_child(Ss_menu_trans) #
	S_menu_object.add_child(Ss_menu_scale)
	S_menu_object.add_child(Ss_menu_type)
	S_menu_object.add_submenu_item("Transform","Transform")
	S_menu_object.add_submenu_item("Scale","Scale")
	#endregion
	
	#endregion
	
	#region VIEW
	#region MODE
	S_menu_mode.set_name("Mode")
	S_menu_mode.add_item("Edit")
	Menu_view.get_popup().add_child(S_menu_mode)
	Menu_view.get_popup().add_submenu_item("Mode","Mode")
	
	#region SPECTATE
	Ss_menu_spec.set_name("Spectate")
	Ss_menu_spec.add_item("Original")
	Ss_menu_spec.add_item("Astronomical Leap")
	S_menu_mode.add_child(Ss_menu_spec)
	S_menu_mode.add_submenu_item("Spectate","Spectate")
	#endregion
	
	#region SIMULATE
	Ss_menu_sim.set_name("Simulate")
	Ss_menu_sim.add_item("Original")
	Ss_menu_sim.add_item("Astronomical Leap")
	S_menu_mode.add_child(Ss_menu_sim)
	S_menu_mode.add_submenu_item("Simulate","Simulate")
	#endregion
	#endregion
	#endregion

func Clear():
	var Clear = load("res://assets/scripts/Object_handler.gd")
	var Level_items = $"../../Level".get_children()
	
func _on_load_file_selected(path):
	Clear()
	var level_Interpreter = preload("res://assets/scripts/Level_interpreter.gd")
	var LI = level_Interpreter.new()
	$"../../Level".add_child(LI)
	var Level = LI.Find_Level_Type(path)
	if (Level == 12):
		$ErrorPop.popup()

func _on_new_confirmed():
	Clear()
