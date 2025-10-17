extends Node2D
class_name Character

signal character_encounter_finished
var is_finished := false

var take_candy : int
var give_candy : int

@export var char_data : CharacterResource

@export_category("Dependencies")
@export var body_parent : Node2D
@export var body_sprite : Sprite2D
@export var left_hand_sprite : Sprite2D
@export var right_hand_sprite : Sprite2D
@export var face_sprite : Sprite2D
@export var left_eye_sprite : Sprite2D
@export var right_eye_sprite : Sprite2D
@export var left_ear_sprite : Sprite2D
@export var right_ear_sprite : Sprite2D
@export var mouth_sprite : Sprite2D
@export var nose_sprite : Sprite2D
@export var hair_sprite : Sprite2D
@export var back_hair_sprite : Sprite2D
@export var mask_sprite : Sprite2D
@export var hat_sprite : Sprite2D
@export var left_leg_sprite : Sprite2D
@export var right_leg_sprite : Sprite2D
@export var full_outfit_sprite : Sprite2D

@export var sing_particles : CPUParticles2D
@export var woof_particles : CPUParticles2D
@export var sniff_particles : CPUParticles2D
@export var anger_particles : CPUParticles2D

@export var response_sprite : Sprite2D

@export var dialogue_holder : DialogueHolder
@onready var anim_player: AnimationPlayer = $anim_player


func rand_chance(probability: float) -> bool:
	return randf() < probability

#func _unhandled_key_input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept") and not event.is_echo():
		#var new_char_data = char_data.duplicate()
		#new_char_data.is_monster = rand_chance(0.75)
		#new_char_data.is_masked = rand_chance(0.5)
		#new_char_data.is_full_outfit = rand_chance(0.16)
		#new_char_data.is_hat = rand_chance(0.75)
#
		#new_char_data.monster_type = randi_range(0, 4)
		#new_char_data.height = randi_range(0, 2)
		#create_costume(new_char_data)
#
func _ready() -> void:
	reset_to_idle()
	dialogue_holder.hide()
	#if char_data:
		#create_costume(char_data)

func reset_to_idle():
	anim_player.queue("RESET")
	anim_player.queue("idle")

func say_dialogue(dialogue: Array[String]):
	dialogue_holder.show()
	dialogue_holder.start_dialogue(dialogue)

func create_costume(char_resource: CharacterResource):
	char_data = char_resource
	show_all_sprites(body_parent)
	
	full_outfit_sprite.hide()
	mask_sprite.hide()
	hat_sprite.hide()
		
	body_sprite.frame = randi_range(0, 9)
	
	var hand_frame = randi_range(0, 5)
	left_hand_sprite.frame = hand_frame
	right_hand_sprite.frame = hand_frame
	
	face_sprite.frame = randi_range(0, 5)
	
	var eye_frame = randi_range(0, 5)
	left_eye_sprite.frame = eye_frame
	right_eye_sprite.frame = eye_frame
	
	var ear_frame = randi_range(0, 5)
	left_ear_sprite.frame = ear_frame
	right_ear_sprite.frame = ear_frame
	
	mouth_sprite.frame = randi_range(0, 5)
	nose_sprite.frame = randi_range(0, 5)
	hair_sprite.frame = randi_range(0, 5)
	back_hair_sprite.frame = randi_range(0, 5)
	
	var leg_frame : int
	if char_resource.height == CharacterResource.HEIGHT_TYPE.RANDOM:
		char_resource.height = randi_range(0, 2) as CharacterResource.HEIGHT_TYPE
	match char_resource.height:
		CharacterResource.HEIGHT_TYPE.SHORT:
			leg_frame = randi_range(0, 2)
		CharacterResource.HEIGHT_TYPE.MEDIUM:
			leg_frame = randi_range(3, 5)
		CharacterResource.HEIGHT_TYPE.TALL:
			leg_frame = randi_range(6, 8)

	left_leg_sprite.frame = leg_frame
	right_leg_sprite.frame = leg_frame
	
	if char_resource.is_masked:
		mask_sprite.show()
		left_ear_sprite.hide()
		right_ear_sprite.hide()
		char_resource.is_hat = false
		mask_sprite.frame = randi_range(0, 5)
	
	if char_resource.is_hat:
		hat_sprite.show()
		hat_sprite.frame = randi_range(0, 5)
	
	if char_resource.is_monster:
		match char_resource.monster_type:
			CharacterResource.MONSTER_TYPE.GENERIC:
				if rand_chance(0.5):
					var new_eye_frame = randi_range(6, 7)
					left_eye_sprite.frame = new_eye_frame
					right_eye_sprite.frame = new_eye_frame
				else:
					var new_ear_frame = randi_range(6, 7)
					left_ear_sprite.frame = new_ear_frame
					right_ear_sprite.frame = new_ear_frame
				
				if rand_chance(0.5):
					nose_sprite.frame = randi_range(6, 7)
				else:
					mouth_sprite.frame = randi_range(6, 7)
				
			CharacterResource.MONSTER_TYPE.WEREWOLF:
				mouth_sprite.hide()
				hair_sprite.hide()
				back_hair_sprite.hide()
				sing_particles.hide()
				woof_particles.show()
				sniff_particles.show()
				face_sprite.frame = randi_range(6, 7)
				nose_sprite.frame = randi_range(8, 9)
				
				var new_ear_sprite = randi_range(8, 9)
				left_ear_sprite.frame = new_ear_sprite
				right_ear_sprite.frame = new_ear_sprite
				
			CharacterResource.MONSTER_TYPE.VAMPIRE:
				mouth_sprite.frame = randi_range(8, 9)
				left_ear_sprite.frame = 6
				right_ear_sprite.frame = 6
				sniff_particles.show()

			CharacterResource.MONSTER_TYPE.GHOST:
				full_outfit_sprite.show()
				full_outfit_sprite.frame = randi_range(0, 2)
				left_leg_sprite.hide()
				right_leg_sprite.hide()
				face_sprite.hide()
				body_sprite.hide()
				hat_sprite.hide()
			
			CharacterResource.MONSTER_TYPE.HORNED:
				hair_sprite.frame = randi_range(6, 7)
			
			CharacterResource.MONSTER_TYPE.BIGHEAD:
				mask_sprite.show()
				left_ear_sprite.hide()
				right_ear_sprite.hide()
				char_resource.is_hat = false
				mask_sprite.frame = randi_range(0, 5)

	if char_resource.is_full_outfit:
		full_outfit_sprite.show()
		face_sprite.hide()
		body_sprite.hide()
		hat_sprite.hide()
		full_outfit_sprite.frame = randi_range(0, 2)
	
	match char_resource.height:
		CharacterResource.HEIGHT_TYPE.SHORT:
			body_parent.position.y = 0
		CharacterResource.HEIGHT_TYPE.MEDIUM:
			body_parent.position.y = -125
		CharacterResource.HEIGHT_TYPE.TALL:
			body_parent.position.y = -260

func show_all_sprites(parent: Node):
	for child in parent.get_children():
		if child is Sprite2D:
			child.show()
		show_all_sprites(child)

func finish_character_encounter(correct := true) -> void:
	#TODO: await dialogue etc
	if dialogue_holder._dialogue_active:
		await dialogue_holder.dialogue_finished
		await get_tree().create_timer(0.3).timeout
	anim_player.play("leave")
	is_finished = true
	character_encounter_finished.emit()



func respond_to_trick(trick_name: String):
	anim_player.play("RESET")
	await get_tree().process_frame
	match trick_name:
		"flash":
			if char_data.is_monster:
				if char_data.monster_type == CharacterResource.MONSTER_TYPE.VAMPIRE or  char_data.monster_type == CharacterResource.MONSTER_TYPE.GHOST:
					anim_player.play("fade")
		"smell":
			if char_data.is_monster:
				if char_data.monster_type == CharacterResource.MONSTER_TYPE.VAMPIRE or  char_data.monster_type == CharacterResource.MONSTER_TYPE.WEREWOLF:
					sing_particles.hide()
					woof_particles.hide()
					sniff_particles.show()
					anim_player.play("sing")
		"dance":
			anim_player.play("dance")
		"sing":
			anim_player.play("sing")
			if char_data.is_monster:
				if char_data.monster_type == CharacterResource.MONSTER_TYPE.WEREWOLF:
					sing_particles.hide()
					woof_particles.show()
			else:
				sing_particles.show()
			sniff_particles.hide()
		
	reset_to_idle()

func _on_detect_area_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	var response_anim: AnimationPlayer = $response_anim
	if Input.is_action_just_pressed("left_click"): #treat attempt
		if char_data.is_monster:
			response_sprite.frame = 0
		else:
			response_sprite.frame = 2
		GameState.candies = GameState.candies - give_candy
	elif Input.is_action_just_pressed("right_click"): #steal attempt
		if char_data.is_monster:
			response_sprite.frame = 1
		else:
			response_sprite.frame = 3
		GameState.candies = GameState.candies + take_candy
