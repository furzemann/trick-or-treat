extends Node2D
class_name DialogueHolder

signal dialogue_finished

var _current_script : Array[String]
var _current_script_index := -1
var _dialogue_active := false

@export var pivot : Node2D
@export var text_position : Vector2
@export var display_time := 2

var text_box : DialogueBox
@export var text_box_scene : PackedScene

#script: ["speaker: dialogue: clue (null default): event (null default)", "event_name", ...]
#if dialogue interrupted / leading to event, emit dialogue_finished

func _ready() -> void:
	start_dialogue(["Toffeeman, Toffeeman", "Where have you gone"])

func start_dialogue(script: Array[String]):
	if _dialogue_active:
		_end_dialogue()

	_current_script = script
	_current_script_index = 0
	_dialogue_active = true
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

func _end_dialogue():
	if text_box:
		text_box.queue_free()

	_dialogue_active = false
	dialogue_finished.emit()

func _show_text_box(dialogue: String):
	text_box = text_box_scene.instantiate()
	text_box.line_finished.connect(_on_text_box_finished_displaying)
	pivot.add_child(text_box)
		
	text_box.global_position = text_position
	text_box.display_text(dialogue)

func _on_text_box_finished_displaying():
	await get_tree().create_timer(display_time).timeout
	_next_line()
