extends Node
class_name CharacterManager

@export var character_scene : PackedScene
@export var character_spawn_centre : Vector2
@export var spacing := 60.
@export var vertical_randomness := 5.
@export var child_spawn_delay := 0.5

var _current_children : Array[Character]
var _timer := 99.
var _timer_active := false

signal encounter_finished

func _ready() -> void:
	var new_data = CharacterResource.new()
	new_data.height = CharacterResource.HEIGHT_TYPE.RANDOM
	spawn_children([new_data, new_data.duplicate(), new_data.duplicate()])

func _process(delta: float) -> void:
	if _timer_active:
		_timer -= delta
		if _timer <= 0.:
			return_remaining_children()

func spawn_children(child_data_array : Array[CharacterResource]):
	for child in _current_children:
		child.queue_free()
	_current_children.clear()
	
	if not character_scene:
		return
	var positions = arrange_positions(child_data_array.size())
	
	for i in child_data_array.size():
		var new_child : Character = character_scene.instantiate()
		add_child(new_child)
		_current_children.push_back(new_child)
		new_child.create_costume(child_data_array[i])
		new_child.global_position = positions[i]
		await get_tree().create_timer(child_spawn_delay).timeout
	
func start_timer(time):
	_timer_active = true
	_timer = time

func arrange_positions(count: int):
	var positions : Array[Vector2] = []
	
	var total_width = (count - 1) * spacing
	var start_x = character_spawn_centre.x - total_width / 2.0
	
	for i in range(count):
		var new_pos : Vector2
		new_pos.x = start_x + i * spacing
		new_pos.y = character_spawn_centre.y + randf_range(-vertical_randomness, vertical_randomness)
		positions.push_back(new_pos)
		
	return positions

func return_remaining_children():
	for child in _current_children:
		if child.is_finished:
			continue
		child.finish_character_encounter(false)

func character_encounter_finished():
	for child in _current_children:
		if not child.is_finished:
			return
	finish_encounter()

func finish_encounter():
	_timer_active = false
	encounter_finished.emit()
