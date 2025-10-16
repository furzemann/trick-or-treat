extends Node2D

@export var candy_label : Label
@export var character_container : HBoxContainer
@export var character_scene : PackedScene
@export var candymann_scene : PackedScene
@export var max_characters : int = 3
@export var candyman_appearance : int = 15

var count : int
var _round := 0

func _ready() -> void:
	
	characters_spawn()
	
func characters_spawn():
	_round += 1
	count = randi_range(1,max_characters)
	if _round % candyman_appearance != 0:
		for i in range(count):
			var character_instance = character_scene.instantiate()
			character_instance.position = Vector2i(i * 30 * 4, 0)
			character_container.add_child(character_instance)
	else:
		var candyman_instance = candymann_scene.instantiate()
		character_container.add_child(candyman_instance)
		
func _process(_delta: float) -> void:
	if character_container.get_child_count() == 0:
		characters_spawn()
