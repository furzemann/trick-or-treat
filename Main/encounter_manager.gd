extends Node
class_name EncounterManager

@export var EncounterOrder : Array[EncounterData] 
@export var character_manager : CharacterManager
@export var encounter_delay : float = 2

var _index := 0

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	start_next_encounter()

func start_next_encounter() -> void:
	if not character_manager or _index >= EncounterOrder.size():
		return
	
	var char_data_array : Array[CharacterResource] = parse_encounter_data(EncounterOrder[_index])
	character_manager.spawn_children(char_data_array, EncounterOrder[_index])
	character_manager.start_timer(EncounterOrder[_index].timer)
	
	_index += 1

func rand_chance(probability: float) -> bool:
	return randf() < probability

func parse_encounter_data(encounter_data : EncounterData) -> Array[CharacterResource]:
	var array : Array[CharacterResource] = []
	var data = encounter_data.duplicate()
	match encounter_data.event:
		EncounterData.SPECIAL_ENCOUNTER.NULL:
			array = data.visitors.duplicate()
		EncounterData.SPECIAL_ENCOUNTER.RANDOM_NO_HIDE:
			var num = randi_range(1, 3)
			for n in range(num):
				var visitor := CharacterResource.new()
				visitor.is_monster = rand_chance(0.5)
				visitor.monster_type = randi_range(0, 4) as CharacterResource.MONSTER_TYPE
				visitor.is_masked = false
				visitor.is_hat = false
				visitor.is_full_outfit = false
				visitor.height = CharacterResource.HEIGHT_TYPE.RANDOM
				array.push_back(visitor)
		EncounterData.SPECIAL_ENCOUNTER.RANDOM_HIDE:
			var num = randi_range(1, 3)
			for n in range(num):
				var visitor := CharacterResource.new()
				visitor.is_monster = rand_chance(0.5)
				visitor.monster_type = randi_range(0, 4) as CharacterResource.MONSTER_TYPE
				visitor.is_masked = rand_chance(0.5)
				visitor.is_hat = rand_chance(0.7)
				visitor.is_full_outfit = rand_chance(0.2)
				visitor.height = CharacterResource.HEIGHT_TYPE.RANDOM
				array.push_back(visitor)
		EncounterData.SPECIAL_ENCOUNTER.CANDYMAN1:
			pass
		EncounterData.SPECIAL_ENCOUNTER.CANDYMAN2:
			pass
		EncounterData.SPECIAL_ENCOUNTER.CANDYMAN3:
			pass
	return array

func encounter_finished():
	await get_tree().create_timer(encounter_delay).timeout
	start_next_encounter()
