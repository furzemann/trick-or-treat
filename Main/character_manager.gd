extends Node
class_name CharacterManager

@export var character_scene : PackedScene
@export var character_spawn_centre : Vector2
@export var spacing := 60.
@export var vertical_randomness := 5.

var _current_children : Array[Character]

func _ready() -> void:
	var new_data = CharacterResource.new()
	spawn_children([new_data, new_data])

func spawn_children(child_data_array : Array[CharacterResource]):
	for child in _current_children:
		child.queue_free()
	_current_children.clear()
	
	if not character_scene:
		return
	
	for child_data in child_data_array:
		var new_child : Character = character_scene.instantiate()
		add_child(new_child)
		_current_children.push_back(new_child)
		new_child.create_costume(child_data)
	
	arrange_children(_current_children)

func arrange_children(children : Array[Character]):
	var count = children.size()
	var total_width = (count - 1) * spacing
	var start_x = character_spawn_centre.x - total_width / 2.0
	
	for i in range(count):
		var node = children[i]
		node.position.x = start_x + i * spacing
		node.position.y = character_spawn_centre.y + randf_range(-vertical_randomness, vertical_randomness)
