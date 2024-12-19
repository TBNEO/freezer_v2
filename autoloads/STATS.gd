extends Node

signal FAIL_DEATH

var shader_override

var Health := 10.0
const MAXHEALTH := 10.0
var Healthlock := 0.0

var Style := 0
var StyleBoost := 1
var StyleDecay := 240
const MAX_STYLEDECAY = 240

var Crosshair

var Freeze := false

const MAX_FREEZE = 180
const MAX_FREEZE_CD = 360

var freeze_time = 0
var freeze_cd = 0

var hurt_vfx = 0.0

func _init():
	process_priority = -1

func style_add(amount: int):
	Style += amount * StyleBoost

func take_damage():
	hurt_vfx = 1.0
	StyleBoost = 1
	Health -= 1
	if Health <= 0:
		FAIL_DEATH.emit()

func _process(delta):
	hurt_vfx = max(0, hurt_vfx - delta)
	
	if Freeze: return
	if StyleBoost > 1:
		if StyleDecay > 0:
			StyleDecay -= 1
		else:
			StyleBoost -= 1
