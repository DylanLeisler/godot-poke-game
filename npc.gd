extends CharacterBody2D

var test_string: String = "Affirmative coach! This is a test with "\
		+ "a lot of text to see what happens with the label type. In fact"\
		+ ", let's make it even longer. I want there to be more lines to"\
		+ " load, that way I can really make sure everything is working"\
		+ " the way it should be! But... what if this string were even longer?"\
		+ " Is there actually a limit? With the way that this is designed,"\
		+ " I... suppose there would have to be a limit at some point. But"\
		+ " where? What is it? How long can I go with this string?"


func _physics_process(delta):
	pass
	
		
func in_area(group_name):
	for body in $npc_interact.get_overlapping_bodies():
		if body.is_in_group(group_name):
			return true
			
	
