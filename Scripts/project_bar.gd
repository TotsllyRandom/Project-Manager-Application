extends Panel

@export var project_file : String
var dict : Dictionary
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dict = DataSave.return_dict(project_file)
	$HBoxContainer/VBoxContainer2/ProjectName.text = dict["project_name"]
	$HBoxContainer/VBoxContainer2/ProjectDesc.text = dict["description"]
