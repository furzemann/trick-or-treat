extends Resource
class_name CharacterResource

enum MONSTER_TYPE {GENERIC, VAMPIRE, WEREWOLF, GHOST}
enum HEIGHT_TYPE {SHORT, MEDIUM, TALL}

var is_monster := false
var is_masked := false
var is_hat := false
var monster_type : MONSTER_TYPE = MONSTER_TYPE.GENERIC
var height : HEIGHT_TYPE = HEIGHT_TYPE.SHORT
