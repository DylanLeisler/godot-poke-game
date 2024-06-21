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
var leftover_text = ""
var is_spillover


# Called when the node enters the scene tree for the first time.
func _ready():
	control.hide()
	#text_box.autowrap_mode = TextServer.AUTOWRAP_WORD	
	panel_height = panel.get_rect().size.y
	panel_width = panel.get_rect().size.x

func show_text_box():
	control.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func display_text(text: String):
	if text_box.text == "" and not is_spillover:
		#text_box.set_text(text)
		show_text_box()
		theme = control.get_theme_font("res://assets/Fonts/main_text_box.theme")
		var char_dimensions = theme.get_string_size("A", 0 ,-1, control.get_theme_default_font_size())
		char_width = char_dimensions.x
		char_height = char_dimensions.y
		
		#for letter in "A B C D E F G H I J K L M O P Q R S T U V W X Y Z".split(" "):
			#prints("Size of ", letter, ": ", theme.get_string_size(letter, 0 ,-1, 10))
		chars_per_line = floor(panel_width/char_width)
		max_visible_lines = floor(panel_height/char_height)-1
		current_line = max_visible_lines
		handle_text(text)
		var text_length = text_box.text.length()
		var total_lines = text_box.text.count("\n")  #floor(text_length/chars_per_line) + 1
		#for c in text_box.text:
			#print(c)
		#print(text_length)
		#print(text.length())
		#if total_lines == text_box.get_line_count():
			#print("total lines matches total lines!")
		#else:
			#prints("total lines = ", total_lines)
			#prints("text_box line count = ", text_box.get_line_count())	
		var char_limit = max_visible_lines*chars_per_line
	else:
		text_box.text = ""
		if not is_spillover:
			control.hide()
		else:
			handle_text(leftover_text)
			
		
	
func advance_text():
	breakpoint
	text_box.scroll_to_line(current_line)
	current_line += 1
	
func handle_text(text):
	var max_chars = chars_per_line
	var formatted_text: String = ""
	
	var array_of_words
	#if is_spillover:
		#array_of_words = leftover_text
		#is_spillover = false
		#breakpoint
	#else:
		#array_of_words = text.split(" ")
		#
		#breakpoint
	prints("text =\n", text)
	array_of_words = text.split(" ")
	prints("array of words is:\n", array_of_words)
	is_spillover = false
	leftover_text = ""
		
	var break_count = 0
	var break_count_max = max_visible_lines
	var formatted_text_line_count = 0
	var word_count = 0 

	for word in array_of_words:
		word_count += 1
		if break_count < break_count_max:
			#breakpoint
			if formatted_text_line_count + word.length() >= max_chars:
				break_count += 1
				if not break_count < break_count_max:
					is_spillover = true
					leftover_text += " " + word
					continue
				#print("newline")
				formatted_text += "\n"
				formatted_text_line_count = 0
			else:
				if formatted_text_line_count > 0:
					formatted_text += " "
					formatted_text_line_count += 1
			#prints("Appending: ", word)
			formatted_text += word
			formatted_text_line_count += word.length()
		else:
			leftover_text += " " + word
	
	
	prints("The contents of formatted_text is:\n", formatted_text)
	text_box.text = formatted_text

