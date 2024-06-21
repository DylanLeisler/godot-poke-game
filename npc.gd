extends CharacterBody2D


func _physics_process(delta):
	if in_area("player"):
		if Input.is_action_just_pressed("interact"):
			MainTextBox.display_text("Affirmative coach! This is a test with "\
			+ "a lot of text to see what happens with the label type. In fact"\
			+ ", let's make it even longer. I want there to be more lines to"\
			+ " load, that way I can really make sure everything is working"\
			+ " the way it should be!")
	
		
func in_area(group_name):
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group(group_name):
			return true
			
	
