extends Node2D

@export var start_Button : Button
@export var next_scene : PackedScene

func _ready() -> void:
	start_Button.pressed.connect(_on_start_button_pressed)
	
func _on_start_button_pressed():
	get_tree().change_scene_to_packed(next_scene)
