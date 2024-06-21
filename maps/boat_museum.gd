extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.global_position = $PlayerEntryDoor.get_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
