extends Node

signal candies_changed
var scene_camera : SceneCamera

func _ready() -> void:
	MusicManager.play_theme("theme1", -10)

var candies : int = 10:
	set(value):
		var diff = (value - candies)
		candies = clamp(value, 0, 999)
		candies_changed.emit(diff)

signal flash_cost_changed
var flash_cost : int = 3:
	set(value):
		flash_cost = value
		flash_cost_changed.emit()

signal smell_cost_changed
var smell_cost : int = 4:
	set(value):
		smell_cost = value
		smell_cost_changed.emit()

signal dance_cost_changed
var dance_cost : int = 5:
	set(value):
		dance_cost = value
		dance_cost_changed.emit()

signal sing_cost_changed
var sing_cost : int = 2:
	set(value):
		sing_cost = value
		sing_cost_changed.emit()

signal penalty_changed
var penalty : int = 0:
	set(value):
		penalty = value
		penalty_changed.emit()
	get:
		return penalty
