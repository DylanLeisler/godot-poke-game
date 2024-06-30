extends MarginContainer

@export var initial_focus_node: Button


# Called when the node enters the scene tree for the first time.
func _ready():
	initial_focus_node = $AspectRatioContainer/VBoxContainer/Button


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_focus_entered():
	$AspectRatioContainer/VBoxContainer/Button.grab_focus()
	pass # Replace with function body.
