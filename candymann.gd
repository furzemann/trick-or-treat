extends Node2D
class_name candyman

@export var needed_candy_for_candyman : int:
	set(value):
		needed_candy_for_candyman = value
	get:
		return needed_candy_for_candyman

@export var label : Label
@export var giveup_button : Button
@export var give_button : Button

func _ready() -> void:
	give_button.show()
	giveup_button.pressed.connect(_on_giveup)
	give_button.pressed.connect(_on_give)
	if CandyManager.candy < needed_candy_for_candyman:
		label.text = "You don't have enough candies to give the candyman"
		give_button.hide()
	label.text = "Candyman asks you for %d candies"% needed_candy_for_candyman
func _on_giveup():
	get_tree().quit()
func _on_give():
	CandyManager.candy -= needed_candy_for_candyman
	queue_free()
