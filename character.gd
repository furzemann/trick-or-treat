extends Node2D
class_name character

@export var trick_button : Button
@export var treat_button : Button
@export var wait_time : float
@export var timer_label : Label

var is_monster : bool
var timer : Timer
@export var texture_rect: TextureRect


signal character_guessed

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.start(wait_time)
	
	trick_button.pressed.connect(_on_trick_button_pressed)
	treat_button.pressed.connect(_on_treat_button_pressed)
	timer.timeout.connect(_on_timer_timeout)
	is_monster = [true, false].pick_random()
	
	if is_monster:
		texture_rect.modulate = Color(1.0, 0.0, 0.0, 1.0)

func _process(_delta: float) -> void:
	if timer:
		timer_label.show()
		timer_label.text = "%.1fs"% timer.time_left
	else:
		timer_label.hide()

func _on_trick_button_pressed():
	if is_monster:
		CandyManager.apply_correct_guess()
		print("Correct Guess")
	else:
		CandyManager.apply_wrong_guess()
		print("Wrong Guess")
	character_guessed.emit()
	queue_free()

func _on_treat_button_pressed():
	if is_monster:
		CandyManager.apply_wrong_guess()
		print("Wrong Guess")
	else:
		CandyManager.apply_correct_guess()
		print("Correct Guess")
	character_guessed.emit()
	queue_free()

func _on_timer_timeout():
	CandyManager.apply_wrong_guess()
	character_guessed.emit()
	print("Timeout")
	queue_free()

func get_img_size() -> float:
	return texture_rect.size.x
