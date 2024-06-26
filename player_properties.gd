extends Node

var player: CharacterBody2D
var player_body_type: String = "CharacterBody2D"
var player_sprite: AnimatedSprite2D

var player_movement_locked: bool = false

func set_player(player_arg):
	player = player_arg
	
func get_player():
	return player

func get_global_position() -> Vector2:
	return player.get_global_position()
	
func get_direction_faced() -> String:
	var dir: String = get_sprite().animation
	return dir
	
func get_sprite() -> AnimatedSprite2D:
	var sprite = player.get_node("AnimatedSprite2D")
	return sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
