extends Button
class_name TrickButton


@export var cost_label : Label
var cost : int:
	set(value):
		cost = value
		cost_label.text = str(cost)
@export var id : String
signal trick_perform

func _ready():
	button_down.connect(_on_button_down)
	
func _on_button_down():
	trick_perform.emit(id, cost)
