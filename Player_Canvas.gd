extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Move the existing player to this layer if not already a child
	if Player.get_parent() != self:
		self.add_child(get_node("/root/Player"))
		print(self.get_children())
		print($StartPosition.get_position())
		Player.to_local()
	else:
		print(self)
		breakpoint
	
	#set_position = $Main/StartPosition.player_pos
	$Player.global_position = $StartPosition.get_position()
		
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
