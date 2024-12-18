extends Node

var Health := 50

signal DEFENSE_FAIL

func damage_campfire():
	Health -= 1
	if Health <= 0:
		DEFENSE_FAIL.emit()
