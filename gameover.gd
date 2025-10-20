extends Node2D

@export var main_game_scene : PackedScene

func _ready() -> void:
	$AnimationPlayer.play("label_show")


func _on_retry_button_down() -> void:
	get_tree().change_scene_to_packed(main_game_scene)
