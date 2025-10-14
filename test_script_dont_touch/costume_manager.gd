class_name CostumeManager extends Resource

@export var tileset : TileSet
@export var costume_archetypes : Dictionary = {
	"human": ["human_headgear", "human_clothes"],
	"vampire": ["vampire_head", "vampire_body"],
	"ghost": ["ghost_cloth"],
	"werewolf": ["werewolf_fur"]
}

func get_costume_groups(archetype: String) -> Array[String]:
	# Return valid group tags from Tileset for this archetype
	if not costume_archetypes.has(archetype):
		return []
	return costume_archetypes[archetype]

func generate_costume(archetype: String) -> Array[Texture2D]:
	var costume_parts : Array[Texture2D] = []

	for group_name in get_costume_groups(archetype):
		var tiles_in_group = tileset.get_tiles_ids_in_group(group_name)
		if tiles_in_group.size() == 0:
			continue
		var tile_id = tiles_in_group.pick_random()
		var tex = tileset.tile_get_texture(tile_id)
		if tex:
			costume_parts.append(tex)

	return costume_parts
