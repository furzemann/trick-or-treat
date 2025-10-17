extends MarginContainer
class_name DialogueBox

var text := ""
var letter_index = 0

var letter_time = 0.01
var space_time = 0.01
var punctuation_time = 0.01
var displaying := false

@export var label : Label
@export var letter_display_timer : Timer
@export var max_width := 700.

signal line_finished

func display_text(text_to_display: String):
	letter_index = 0
	text = text_to_display
	label.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(size.x, max_width)
	
	if size.x > max_width:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
	
	global_position.x -= size.x / 2.
	global_position.y -= size.y / 2.
	
	label.text = ""
	_display_letter()

func _display_letter():
	displaying = true
	label.text += text[letter_index]
	letter_index += 1
	if letter_index >= text.length():
		line_finished.emit()
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			letter_display_timer.start(punctuation_time)
		" ":
			letter_display_timer.start(space_time)
		_:
			letter_display_timer.start(letter_time)

func _on_timer_timeout():
	_display_letter()
