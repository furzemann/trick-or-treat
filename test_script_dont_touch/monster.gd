class_name monster extends character

enum monster_types_enum {VAMPIRES, WEREWOLF, GHOST}

@export var monster_type : monster_types_enum

#TODO
func _on_reveal() -> void:
	print("Monster revealed")
