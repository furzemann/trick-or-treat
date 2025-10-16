extends Node
class_name CharacterManager

@export var character_spawn_centre : Vector2
@export var spacing := 60.
@export var vertical_randomness := 5.

var _current_children : Array[Character]

func spawn_children(child_data_array : Array[CharacterResource]):
	pass

func arrange_children(children : Array[Character]):
	var count = children.size()
	var total_width = (count - 1) * spacing
	var start_x = character_spawn_centre.x - total_width / 2.0
	
	for i in range(count):
		var node = children[i]
		node.position.x = start_x + i * spacing
		node.position.y = character_spawn_centre.y + randf_range(-vertical_randomness, vertical_randomness)
