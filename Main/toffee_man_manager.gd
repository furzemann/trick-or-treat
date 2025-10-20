extends Node2D
class_name ToffeeManManager

@export var gameover_scene : PackedScene
@export var trick_ui : TrickUiManager
@export var dialogue_holder : DialogueHolder
@export var detection_area : Area2D

@export var candyman1_dialogue : Array[String]
@export var candyman2_dialogue : Array[String]
@export var candyman3_dialogue : Array[String]

@export var candyman_fail_dialogue : Array[String]
@export var candyman_trick_dialogue : Array[String]
@export var candyman1_treat_dialogue : Array[String]
@export var candyman2_treat_dialogue : Array[String]
@export var candyman3_treat_dialogue : Array[String]

var _current_treat_dialogue : Array[String]
var _next_cost := 50

signal encounter_finished
signal anim_finished

func _ready():
	_disable_detector()
	dialogue_holder.dialogue_started.connect(_on_dialogue_started)

func _on_dialogue_started():
	SfxManager.voice_of_candyman(8.)

func CANDYMAN1():
	_appear_candyman()
	await anim_finished
	dialogue_holder.start_dialogue(candyman1_dialogue)
	await dialogue_holder.dialogue_finished
	_current_treat_dialogue = candyman1_treat_dialogue
	_next_cost = 60
	_enable_detector()


func CANDYMAN2():
	_appear_candyman()
	await anim_finished
	dialogue_holder.start_dialogue(candyman2_dialogue)
	await dialogue_holder.dialogue_finished
	_current_treat_dialogue = candyman2_treat_dialogue
	_next_cost = 90
	_enable_detector()


func CANDYMAN3():
	_appear_candyman()
	await anim_finished
	dialogue_holder.start_dialogue(candyman3_dialogue)
	await dialogue_holder.dialogue_finished
	_current_treat_dialogue = candyman3_treat_dialogue
	_next_cost = 150
	_enable_detector()


func _appear_candyman():
	MusicManager.play_theme('candyman_theme')
	trick_ui.disable_ui()
	$AnimationPlayer.play("toffeeMan appears")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play_backwards("idle")
	anim_finished.emit()

func _disappear_candyman():
	MusicManager.play_theme('theme2')
	$AnimationPlayer.play_backwards("toffeeMan appears")
	await $AnimationPlayer.animation_finished
	anim_finished.emit()
	trick_ui.enable_ui()

func _on_gameover():
	get_tree().change_scene_to_packed(gameover_scene)

func _on_detect_toffeeman_area_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("left_click"):
		_disable_detector()
		var fail : bool = GameState.toffeeman_cost > GameState.candies
		GameState.candies = GameState.candies - GameState.toffeeman_cost
		if fail:
			dialogue_holder.start_dialogue(candyman_fail_dialogue)
			await dialogue_holder.dialogue_finished
			_on_gameover()
		else:
			dialogue_holder.start_dialogue(_current_treat_dialogue)
			await dialogue_holder.dialogue_finished
			_disappear_candyman()
			await anim_finished
			dialogue_holder.remove_last_dialogue()
			encounter_finished.emit()
			GameState.toffeeman_cost = _next_cost
	elif Input.is_action_just_pressed("right_click"):
		dialogue_holder.start_dialogue(candyman_trick_dialogue)
	else:
		return

func _disable_detector():
	detection_area.collision_layer = 0

func _enable_detector():
	detection_area.collision_layer = 1
