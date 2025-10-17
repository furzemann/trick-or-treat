extends Node2D
class_name DialogueHolder

signal dialogue_finished

var _current_script : Array[String]
var _current_script_index := -1
var _dialogue_active := false

@export var pivot : Node2D
@export var dialogue_tail : Sprite2D
@export var text_position : Vector2
@export var display_time := 4

@export var init_text_box : DialogueBox
var text_box : DialogueBox
#script: ["speaker: dialogue: clue (null default): event (null default)", "event_name", ...]
#if dialogue interrupted / leading to event, emit dialogue_finished

func _ready() -> void:
	dialogue_tail.hide()
	init_text_box.hide()
	#start_dialogue(["Toffeeman, Toffeeman", "Where have you gone"])

func start_dialogue(script: Array[String]):
	if _dialogue_active:
		_remove_last_dialogue()
	_current_script = script
	_current_script_index = 0
	_dialogue_active = true
	dialogue_tail.show()

	_next_line()

func _next_line():
	if _current_script_index >= _current_script.size():
		_end_dialogue()
		return
	
	if text_box:
		text_box.queue_free()

	var current_dialogue : String = _current_script[_current_script_index]
	_show_text_box(current_dialogue)

	_current_script_index += 1

func _remove_last_dialogue():
	if text_box:
		text_box.queue_free()
		dialogue_tail.hide()

func _end_dialogue(): 
	_dialogue_active = false
	dialogue_finished.emit()

func _show_text_box(dialogue: String):
	text_box = init_text_box.duplicate()
	text_box.line_finished.connect(_on_text_box_finished_displaying)
	text_box.position_set.connect(_set_tail)
	pivot.add_child(text_box)
	text_box.show()
	text_box.position = text_position
	text_box.display_text(dialogue)

func _set_tail() -> void:
	dialogue_tail.position = text_box.position + Vector2(text_box.size.x/2, text_box.size.y/2)
	dialogue_tail.rotation = dialogue_tail.global_position.angle_to_point(pivot.global_position)

func _on_text_box_finished_displaying():
	await get_tree().create_timer(display_time).timeout
	_next_line()
