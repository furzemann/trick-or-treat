extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("label_show")


func _on_retry_button_down() -> void:
	get_tree().change_scene_to_file('res://Main/GameScene.tscn')
