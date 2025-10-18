extends Node2D
class_name NoteUiManager

var _visible := false
@export var flipped := false
@export var note : ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	_visible = false
	note.hide()

func show_note():
	SfxManager.play_sfx('book_open')
	if _visible: 
		hide_note()
		return
	_visible = true
	note.show()

func hide_note():
	SfxManager.play_sfx('book_open',0.0,true,1.7)
	_visible = false
	note.hide()

func flip():
	SfxManager.play_sfx('page_turn',3.0)
	if not flipped:
		animation_player.play("page_flip")
	else:
		animation_player.play_backwards("page_flip")
	flipped = not flipped
