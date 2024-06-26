extends Node

var global_cd: float = 0.35
var global_cd_delta: float = 0
var on_cooldown: bool = false

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	if on_cooldown:
		global_cd_delta += delta
		if global_cd_delta >= global_cd:
			on_cooldown = false
			global_cd_delta = 0
			set_physics_process(false)

func is_action_just_pressed(action: StringName, exact_match: bool = false) -> bool:
	if not on_cooldown and Input.is_action_just_pressed(action, exact_match):
		on_cooldown = true  # Set the cooldown flag
		set_physics_process(true)
		return true
	return false

func is_action_pressed(action: StringName, exact_match: bool = false) -> bool:
	return Input.is_action_pressed(action, exact_match)
	#if not on_cooldown and Input.is_action_pressed(action, exact_match):
		#on_cooldown = true  # Set the cooldown flag
		#set_physics_process(true)
		#return true
	#return false
