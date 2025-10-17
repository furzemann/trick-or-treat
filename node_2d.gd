extends Node2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		SfxManager.random_npc_sounds(true, 10.)

func _ready() -> void:
	MusicManager.play_theme("candyman_theme")
