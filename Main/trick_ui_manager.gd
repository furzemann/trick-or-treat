extends Node2D
class_name TrickUiManager

@export var flash_button : TrickButton
@export var smell_button : TrickButton
@export var dance_button : TrickButton
@export var sing_button : TrickButton

func _ready():
	GameState.flash_cost_changed.connect(_update_visuals)
	GameState.smell_cost_changed.connect(_update_visuals)
	GameState.dance_cost_changed.connect(_update_visuals)
	GameState.sing_cost_changed.connect(_update_visuals)
	_update_visuals()

func _update_visuals():
	flash_button.cost = GameState.flash_cost
	smell_button.cost = GameState.smell_cost
	dance_button.cost = GameState.dance_cost
	sing_button.cost = GameState.sing_cost

func disable_ui():
	hide()
	flash_button.set_disabled(true)
	smell_button.set_disabled(true)
	dance_button.set_disabled(true)
	sing_button.set_disabled(true)

func enable_ui():
	show()
	flash_button.set_disabled(false)
	smell_button.set_disabled(false)
	dance_button.set_disabled(false)
	sing_button.set_disabled(false)
