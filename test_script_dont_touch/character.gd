@abstract class_name character extends Node2D

enum height_enum {SHORT, MEDIUM, TALL}
enum archetype_enum {HUMAN, MONSTER}

@export var height_type : height_enum
@export var archetype : archetype_enum
@export var reveal_timer := 5.0

signal time_expired()

var is_revealed := false
var is_human : bool

#TODO
func _ready() -> void:
	start_timer()
	
func start_timer() -> void:
	await get_tree().create_timer(reveal_timer).timeout
	if not is_revealed:
		emit_signal("time_expired")

func reveal_identity() -> void:
	is_revealed = true
	_on_reveal()
	
@abstract func _on_reveal() -> void
