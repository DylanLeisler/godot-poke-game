extends CharacterBody2D


const base_speed = 16 # How fast the player will move (pixels/sec).
@export var speed = base_speed*2
var screen_size # Size of the game window.
var player_global_position: Vector2 # Used to check if player has moved


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	#print(velocity)

	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.animation = "right"
		velocity.x += 1
	elif Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.animation = "left"
		velocity.x -= 1
	elif Input.is_action_pressed("move_down"):
		$AnimatedSprite2D.animation = "down"
		velocity.y += 1
	elif Input.is_action_pressed("move_up"):
		$AnimatedSprite2D.animation = "up"
		velocity.y -= 1

	if velocity.length() >= 1.0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.set_frame(1)


	var delta_position = velocity * delta
	position += delta_position
	var collision = move_and_collide(delta_position)
	is_sliding_collision(collision)
	position = position.clamp(Vector2.ZERO, screen_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Checks if player is colliding with something and if their position has changed
# If true, it resets the animation to 1
func is_sliding_collision(isCollision):
	if isCollision and player_global_position == self.get_global_position():
		$AnimatedSprite2D.set_frame_and_progress(1, 0.0)	
	player_global_position = self.get_global_position()
