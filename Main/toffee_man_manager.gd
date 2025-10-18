extends Node2D
class_name ToffeeManManager

@export var trick_ui : Node2D
@export var dialogue_holder : DialogueHolder

@export var candyman1_dialogue : Array[String]
@export var candyman1_base_cost : int = 5
@export var candyman2_dialogue : Array[String]
@export var candyman2_base_cost : int = 30
@export var candyman3_dialogue : Array[String]
@export var candyman3_base_cost : int = 60

var cost : int

signal encounter_finished
signal gameover

func _ready() -> void:
	$detect_toffeeman_area.hide()
	dialogue_holder.hide()
	gameover.connect(_on_gameover)

func CANDYMAN1():
	say_dialogue(candyman1_dialogue)
	cost = candyman1_base_cost + GameState.penalty

func CANDYMAN2():
	say_dialogue(candyman2_dialogue)
	cost = candyman2_base_cost + GameState.penalty

func CANDYMAN3():
	say_dialogue(candyman3_dialogue)
	cost = candyman3_base_cost + GameState.penalty

func _appear_candyman():
	$AnimationPlayer.play("toffeeMan appears")
	await $AnimationPlayer.animation_finished
	$detect_toffeeman_area.show()

func _disappear_candyman():
	$AnimationPlayer.play_backwards("toffeeMan appears")
	await $AnimationPlayer.animation_finished
	$detect_toffeeman_area.hide()
	encounter_finished.emit()

func say_dialogue(dialogue: Array[String]):
	dialogue_holder.show()
	dialogue_holder.start_dialogue(dialogue)
	#Play_sfx Candyman Dialgue

func _on_detect_toffeeman_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		if GameState.candies > cost:
			GameState.candies -= cost
			encounter_finished.emit()
		else:
			gameover.emit()


func _on_gameover():
	pass
