extends Node

signal loading_project(name)

var current_project_name : String
var current_project_description : String

var current_project_tasks : Dictionary = {}

var loaded_a_project := false

func load_project(project_name):
	current_project_name = DataSave.return_dict(project_name)["project_name"]
	current_project_description = DataSave.return_dict(project_name)["description"]
	loading_project.emit(project_name)
	loaded_a_project = true

func create_project(project_name := "Untitled Project", description := "Enter a short description to remind yourself of what you're working towards!"):
	current_project_name = project_name
	current_project_description = description
	
	current_project_tasks = {
		"Current Stage" : {
			description : "Your current project"
		}
	}
	print("made project" + current_project_name)
	
