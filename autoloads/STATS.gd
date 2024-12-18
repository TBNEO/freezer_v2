extends Node

var Health := 10
const MAXHEALTH := 10

var Style := 0
var StyleBoost := 1

var Crosshair

func _init() -> void:
	process_priority = -1

func style_add(amount: int) -> void:
	Style += amount * StyleBoost

func take_damage() -> void:
	Health -= 1
	Style = max(0, Style - 200)
