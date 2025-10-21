extends Node2D

@export var main_game_scene : PackedScene
@export var retry_button : Button
func _ready() -> void:
	$AnimationPlayer.play("label_show")
	retry_button.pressed.connect(_on_retry_button_down)

func _on_retry_button_down() -> void:
	get_tree().change_scene_to_packed(main_game_scene)
