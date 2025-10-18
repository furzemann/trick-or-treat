extends Node2D

@export var candy_counter : RichTextLabel
@export var update_counter : RichTextLabel

func _ready() -> void:
	GameState.candies_changed.connect(update_candy_counter)
	update_candy_counter()

func update_candy_counter(diff: int = 1):
	SfxManager.play_sfx('candy', 5.0,true,1.9)
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()
	var operator : String = "+" if sign(diff) >= 0 else "-"
	update_counter.text = operator + str(diff)
	$AnimationPlayer.play("update_anim")
	
	var set_num = func(num):
		candy_counter.text = "[wave]" + str(num)
	
	var init_num = GameState.candies - diff
	var tween = create_tween()
	tween.tween_method(set_num, init_num, GameState.candies, diff * 0.02).set_ease(Tween.EASE_IN)
	#candy_counter.text = "[wave]" + str(GameState.candies)
