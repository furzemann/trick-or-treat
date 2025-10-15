extends Resource
class_name CharacterResource

enum MONSTER_TYPE {GENERIC, VAMPIRE, WEREWOLF, GHOST, HORNED}
enum HEIGHT_TYPE {SHORT, MEDIUM, TALL}

@export var is_monster := false
@export var is_masked := false
@export var is_hat := false
@export var is_full_outfit := false
@export var monster_type : MONSTER_TYPE = MONSTER_TYPE.GENERIC
@export var height : HEIGHT_TYPE = HEIGHT_TYPE.SHORT
