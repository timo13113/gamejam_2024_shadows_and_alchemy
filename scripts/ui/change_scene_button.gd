extends Button

@export_file("*.tscn", "*.scn") var scene_path: String

func pressed():
	var test = load(scene_path) 
	get_tree().change_scene_to_packed(test)
