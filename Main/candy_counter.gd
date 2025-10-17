extends Node2D

@export var candy_counter : RichTextLabel

func _ready() -> void:
	GameState.candies_changed.connect(update_candy_counter)
	update_candy_counter()

func update_candy_counter(sgn: int = 1):
	candy_counter.text = "[wave]" + str(GameState.candies)
