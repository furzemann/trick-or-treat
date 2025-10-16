extends Node2D
class_name NoteUiManager

var _visible := false
@export var flipped := false
@export var note : ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hide_note()

func show_note():
	if _visible: 
		hide_note()
		return
	_visible = true
	note.show()

func hide_note():
	_visible = false
	note.hide()

func flip():
	if not flipped:
		animation_player.play("page_flip")
	else:
		animation_player.play_backwards("page_flip")
	flipped = not flipped
