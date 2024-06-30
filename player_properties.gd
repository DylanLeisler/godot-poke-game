extends Node

var player: CharacterBody2D
var player_body_type: String = "CharacterBody2D"
var player_sprite: AnimatedSprite2D

var movement_locked: bool = false
var start_menu_open: bool = false

var sprite: AnimatedSprite2D :
	get:
		return player.get_node("AnimatedSprite2D")
		
var direction_faced: String :
	get:
		return sprite.animation
	

enum PlayerState {
	FREE,
	MENU, 
	INTERACTION
}

var player_state: PlayerState : 
	set(arg):
		player_state = arg
		
		match arg:
			PlayerState.FREE:
				movement_locked = false
			PlayerState.MENU:
				movement_locked = true
				start_menu_open = true
			PlayerState.INTERACTION:
				movement_locked = true
				
		if not arg == PlayerState.MENU:
			start_menu_open = false
			
		return self
		
	get:
		return player_state
	


func set_player(player_arg):
	player = player_arg
	return self
func get_player():
	return player

func get_global_position() -> Vector2:
	return player.get_global_position()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
