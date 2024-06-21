extends Node

var new_scene = false

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	pass
	
func new_game():
	get_tree().change_scene_to_file("res://maps/boat_museum.tscn")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

