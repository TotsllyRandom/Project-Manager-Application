extends Control

@export var project_bar : PackedScene

func _ready() -> void:
	show_project_list()

func show_project_list():
	get_projects()
	$"BG/Usable Area/ProjectList".visible = true
	$"BG/Usable Area/CurrentProject".visible = false

func _process(delta: float) -> void:
	fix_visuals()

func fix_visuals():
	$"BG/Usable Area".size = Vector2(
		size.x - 20,
		size.y - 20,
	)
	$"BG/Usable Area".position = Vector2i(
		10,
		10,
	)
	
func get_projects():
	var parent = $"BG/Usable Area/ProjectList/HBoxContainer/Projects"
	DataSave.load_player_dir()
	for child in parent.get_children():
		child.queue_free()
	for project in DataSave.player_data:
		var new = project_bar.instantiate()
		new.name = project
		new.project_file = project
		new.visible = true
		parent.add_child(new)

func _on_create_pressed() -> void:
	ProjectHandler.create_project($"BG/Usable Area/ProjectList/HBoxContainer/NewProject/Name".text,$"BG/Usable Area/ProjectList/HBoxContainer/NewProject/Description".text)
	print("made project")
	DataSave.save_project_data()
	show_project_list()
