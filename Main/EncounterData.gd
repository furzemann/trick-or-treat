extends Resource
class_name EncounterData

enum SPECIAL_ENCOUNTER {RANDOM_NO_HIDE, RANDOM_HIDE, CANDYMAN1, CANDYMAN2, CANDYMAN3, NULL}

@export var event : SPECIAL_ENCOUNTER = SPECIAL_ENCOUNTER.NULL
@export var visitors : Array[CharacterResource]
@export var timer : float = 15
