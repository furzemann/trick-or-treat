extends Node

var candy : int = 50

func apply_correct_guess():
	candy += 1

func apply_wrong_guess():
	candy -= 1
