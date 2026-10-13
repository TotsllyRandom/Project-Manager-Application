extends Node

## Default Player Data
var default_project_data = {
	"project_name" : "Untitled Project",
	"description" : "Enter a short description to remind yourself of what you're working towards!",
	"job" : "quickloans",
	"tasks" : {}
}

## Real Player Data
var player_data = []


const PLAYER_DIR := "user://"


func _ready() -> void:
	load_player_dir()
	if len(player_data) == 1:
		ProjectHandler.load_project(player_data[0])

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("SAVING PLAYER DATA: ", player_data)
		save_player_data()
		get_tree().quit()


func load_player_dir() -> void:
	var dir = DirAccess.open(PLAYER_DIR)

	if dir == null:
		return
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		if dir.current_is_dir():
			print("Found project: " + file_name)
			player_data.append(file_name)
		else:
			print("Found file: " + file_name)
			
		file_name = dir.get_next()
	print(OS.get_user_data_dir())
	
	dir.list_dir_end()

func save_player_data():
	var file = FileAccess.open(PLAYER_DIR, FileAccess.WRITE)
	if file:
		print("found Player Data file")
	file.store_string(JSON.stringify(player_data))
	print("Stored Data: "+JSON.stringify(player_data))
	file.close()

func load_project(_name):
	pass
