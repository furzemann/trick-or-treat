class_name CharacterSpawner extends Node

@export var human_scene : PackedScene
@export var monster_scene : PackedScene
@export var costume_manager : CostumeManager
@export var dialogue_manager : DialogueManager
@export var candyman_manager : NodePath

func spawn_character():
	var is_monster := randf() < 0.5
	var character_scene = monster_scene if is_monster else human_scene
	var _character = character_scene.instantiate()
	
	_character.height_type = [0 , 1, 2].pick_random() #Short : 0, Medium : 1 , Tall : 2
	_character.archetype = 1 if is_monster else 0 #Human : 0 , Monster : 1

	if is_monster:
		_character.monster_type = [0,1,2].pick_random() #Vamp : 0 , WERE : 1, GHOST : 2
		_character.set_costume(costume_manager.generate_costume(_character.monster_type))
	else:
		_character.set_costume(costume_manager.generate_costume("human")) 

	_character.connect("guess_made", Callable(self, "_on_guess"))
	_character.connect("time_expired", Callable(self, "_on_time_expired"))
	add_child(_character)

func _on_guess(correct: bool):
	var economy = get_node("/root/GameRoot/CandyEconomy")
	if correct:
		economy.apply_correct_guess()
	else:
		economy.apply_wrong_guess()
	get_node(candyman_manager).on_character_done()

func _on_time_expired():
	var economy = get_node("/root/GameRoot/CandyEconomy")
	economy.apply_wrong_guess()
	get_node(candyman_manager).on_character_done()
