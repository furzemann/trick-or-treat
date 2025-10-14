class_name CandyManager extends Resource


signal candy_changed(new_amount: int)
signal combo_changed(multiplier: float)

@export var base_candy : int = 10
@export var combo_step : int = 2
@export var combo_loss_penalty : int = 2
@export var min_combo : int = 1
@export var max_combo : int = 32

var candy : int = 50
var combo : int = 1

func apply_correct_guess():
	combo *= min(max_combo, combo_step)
	var gain = int(base_candy * combo)
	candy += gain
	emit_signal("candy_changed", candy)
	emit_signal("combo_changed", combo)

func apply_wrong_guess():
	combo /= max(min_combo, combo_loss_penalty)
	var loss = int(base_candy * combo)
	candy -= loss
	emit_signal("candy_changed", candy)
	emit_signal("combo_changed", combo)
