extends CanvasLayer

@onready
var control: Control = $TextHandler/Control
@onready
var panel: Panel = $TextHandler/Control/Panel
@onready
var text_box: Label = $TextHandler/Control/Panel/TextBox

var current_line = 0
var line_height
var line_width
var line_count
var panel_height
var panel_width
var char_width
var char_height
var chars_per_line
var max_visible_lines
var theme
var spillover_text = ""
var is_spillover


# Called when the node enters the scene tree for the first time.
func _ready():
	control.hide()
	#text_box.autowrap_mode = TextServer.AUTOWRAP_WORD	
	panel_height = panel.get_rect().size.y
	panel_width = panel.get_rect().size.x

func show_text_box(lock_player_position=true):
	control.show()
	if lock_player_position:
		lock_player()
		
func lock_player():
	PlayerProperties.player_movement_locked = true
	
func unlock_player():
	PlayerProperties.player_movement_locked = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func display_text(text: String):
	if text_box.text == "" and not is_spillover:
		show_text_box()
		
		# Theme font dimensions
		theme = control.get_theme_font("res://assets/Fonts/main_text_box.theme")
		var char_dimensions = theme.get_string_size("A", 0 ,-1, control.get_theme_default_font_size())
		char_width = char_dimensions.x
		char_height = char_dimensions.y
		
		# Lines
		chars_per_line = floor(panel_width/char_width)-1
		max_visible_lines = floor(panel_height/char_height)-1

		handle_text(text)
	
	else:
		text_box.text = ""
		if not is_spillover:
			control.hide()
			unlock_player()
		else:
			handle_text(spillover_text)
			
		
	
func advance_text():
	"""For scrolling, but not yet implemented"""
	pass
	
func handle_text(text):
	
	# What will ultimately be set as the text for the text_box label
	var formatted_text: String = ""
	var formatted_text_line_length = 0
	
	# Did the text exceed one full text box?
	# Spillover text gets passed back into this function as just 'text'
	# So these both should be reset here
	is_spillover = false
	spillover_text = ""
	
	# Counters because GDScript is kinda ass
	var break_count_max = max_visible_lines
	var break_count = 0

	# Cycle through each word in the text to calculate length
	for word in text.split(" "):
		var word_length = word.length()
		# Checks if max amount of line breaks has (not) been reached
		if break_count < break_count_max:
			# Will the addition of the next word exceed the line length?
			if formatted_text_line_length + word_length >= chars_per_line:
				# If so, add a line break
				break_count += 1
				# If that incrementation causes the max to be exceeded, then
				# start funneling the rest of the words into spillover
				if not break_count < break_count_max:
					funnel_spillover_word(word)
					# Force this loop to repeat until all words have been handled
					continue
				formatted_text += "\n"
				formatted_text_line_length = 0
			# If the next word does NOT push over the line length
			# Add a space if it isn't the beginning of a new line
			elif formatted_text_line_length > 0:
				formatted_text += " "
				formatted_text_line_length += 1
				
			formatted_text += word
			formatted_text_line_length += word_length
		# If max line breaks has been reached
		else:
			spillover_text += " " + word
			
	#prints("The contents of formatted_text is:\n", formatted_text)
	text_box.text = formatted_text
	
func funnel_spillover_word(word):
	is_spillover = true
	spillover_text += " " + word
