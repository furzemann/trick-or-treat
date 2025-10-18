extends Node2D
class_name TrickManager

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var trick_dialogue_holder : DialogueHolder
@export var character_manager : CharacterManager
var _trick_active := false

func try_trick(trick_name : String, cost : int):
	if _trick_active or cost > GameState.candies:
		return
	GameState.candies = GameState.candies - cost
	match trick_name:
		"flash":
			flashlight_trick()
		"smell":
			smell_trick()
		"dance":
			dance_trick()
		"sing":
			sing_trick()
	await get_tree().create_timer(0.3)
	character_manager.try_trick(trick_name)

func flashlight_trick():
	SfxManager.play_sfx("trick")
	_trick_active = true
	trick_dialogue_holder.start_dialogue(["Trick or Treat, get really lit!"])
	await get_tree().create_timer(0.2).timeout
	animation_player.play("flashlight_trick")
	await get_tree().create_timer(.45).timeout
	SfxManager.play_sfx("ui_sfx2")
	await get_tree().create_timer(1.65).timeout
	trick_dialogue_holder._remove_last_dialogue()
	end_trick()

func smell_trick():
	SfxManager.play_sfx("trick")
	_trick_active = true
	trick_dialogue_holder.start_dialogue(["Trick or Treat, smell my feet!"])
	await get_tree().create_timer(0.2).timeout
	animation_player.play("smell_trick")
	await get_tree().create_timer(2.).timeout
	trick_dialogue_holder._remove_last_dialogue()
	end_trick()

func dance_trick():
	SfxManager.play_sfx("trick")
	_trick_active = true
	trick_dialogue_holder.start_dialogue(["Trick or Treat, dance to the beat!"])
	await get_tree().create_timer(2.).timeout
	trick_dialogue_holder._remove_last_dialogue()
	end_trick()

func sing_trick():
	SfxManager.play_sfx("trick")
	SfxManager.sing(true, 4., randf_range(.3,1.), 0.0, 3.28)
	_trick_active = true
	trick_dialogue_holder.start_dialogue(["Trick or Treat, sing really neat!"])
	await get_tree().create_timer(2.).timeout
	trick_dialogue_holder._remove_last_dialogue()
	end_trick()

func end_trick():
	_trick_active = false
