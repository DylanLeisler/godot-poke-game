extends Node2D

var area_entered: String

@onready
var text_to_display = get_parent().test_string

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	for area in get_children():
		if area is Area2D:
			var callable_entered = Callable(self, "_on_body_entered").bind(area.name)
			area.connect("body_entered", callable_entered)
			area.connect("body_exited", Callable(self, "_on_body_exited").bind(area.name))
			
func _on_body_entered(body, area_name):
	if body.is_in_group("player"):
		set_physics_process(true)
		area_entered = area_name
	
func _on_body_exited(body, area_name):
	if body.is_in_group("player"):
		set_physics_process(false)
		area_entered = ""
		
func _physics_process(delta):
	if PlayerInput.is_action_just_pressed("interact"):
		if PlayerProperties.player_state == PlayerProperties.PlayerState.INTERACTION:
			display(text_to_display)
		elif PlayerProperties.player_state == PlayerProperties.PlayerState.FREE:
			var correspondence = [area_entered, PlayerProperties.direction_faced]
			match correspondence:
				["North", "down"], ["South", "up"], ["West", "right"], ["East", "left"]:
					display(text_to_display)
				_:
					pass
					
func display(text):
	MainTextBox.display_text(text)
