extends Node

var Health := 10.0
const MAXHEALTH := 10.0
var Healthlock := 0.0

var Style := 0
var StyleBoost := 1

var Crosshair

func _init():
	process_priority = -1

func style_add(amount: int):
	Style += amount * StyleBoost
