extends Node
class_name EncounterManager

@export var EncounterOrder : Array[EncounterData] 
@export var character_manager : CharacterManager
@export var encounter_delay : float = 2
@export var toffee_man_manager : ToffeeManManager
@export var trick_ui_manager : TrickUiManager
@export var note_manager : NoteUiManager

var _index := 0

func _ready() -> void:
	toffee_man_manager.encounter_finished.connect(encounter_finished)
	trick_ui_manager.disable_ui()
	note_manager.disable_note()
	await get_tree().create_timer(1).timeout
	start_next_encounter()

func start_next_encounter() -> void:
	if not character_manager or _index >= EncounterOrder.size():
		return
	
	var char_data_array : Array[CharacterResource] = parse_encounter_data(EncounterOrder[_index])
	var encounter_data : EncounterData = EncounterOrder[_index]
	character_manager._timer = encounter_data.timer
	character_manager.spawn_children(char_data_array, encounter_data)
	character_manager.start_timer(encounter_data.timer)
	
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
			toffee_man_manager.CANDYMAN1()
			pass
		EncounterData.SPECIAL_ENCOUNTER.CANDYMAN2:
			toffee_man_manager.CANDYMAN2()
			pass
		EncounterData.SPECIAL_ENCOUNTER.CANDYMAN3:
			toffee_man_manager.CANDYMAN3()
			pass
	return array

func encounter_finished():
	if _index == 1:
		note_manager.enable_note()
	await get_tree().create_timer(encounter_delay).timeout
	start_next_encounter()
	
