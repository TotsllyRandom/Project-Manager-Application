extends Node

## Default Player Data
var default_project_data = {
	"project_name" : "Untitled Project",
	"description" : "Enter a short description to remind yourself of what you're working towards!",
	"tasks" : {}
}

## Real Player Data
var player_data = []

var save : Dictionary


const PLAYER_DIR := "user://"
const PATH := PLAYER_DIR + "userdata.json"
const PROJECTS_PATH := PLAYER_DIR + "projects/"


func _ready() -> void:
	DirAccess.make_dir_recursive_absolute(PROJECTS_PATH)
	load_player_dir()
	if len(player_data) == 1:
		ProjectHandler.load_project(player_data[0])

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("SAVING PLAYER DATA: ", player_data)
		save_project_data()
		get_tree().quit()


func load_player_dir() -> void:
	player_data = []
	var dir = DirAccess.open(PROJECTS_PATH)
	
	if dir == null:
		return
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		if dir.current_is_dir():
			print("Found folder: " + file_name)
		else:
			print("Found file: " + file_name)
			player_data.append(file_name)
			
		file_name = dir.get_next()
	print(OS.get_user_data_dir())
	
	dir.list_dir_end()

func save_project_data():
	if ProjectHandler.current_project_name == "":
		return
	save = {
		"project_name" : ProjectHandler.current_project_name,
		"description" : ProjectHandler.current_project_description,
		"tasks" : ProjectHandler.current_project_tasks
	}
	var p = PROJECTS_PATH + ProjectHandler.current_project_name + ".json"
	var file = FileAccess.open(p, FileAccess.WRITE)
	if file:
		print("found Project Data file")
	file.store_string(JSON.stringify(save))
	file.close()

func load_project(_name):
	pass

func return_dict(file_name):
	return JSON.parse_string(FileAccess.get_file_as_string(PROJECTS_PATH + file_name))
