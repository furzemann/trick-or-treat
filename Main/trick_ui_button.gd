extends Button
class_name TrickButton

@export var cost := 3
@export var cost_label : Label

func _ready():
	button_down.connect(_on_button_down)
	
func _on_button_down():
	print(self)
