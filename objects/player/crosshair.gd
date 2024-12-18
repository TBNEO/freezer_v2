extends Node2D

var firing = false
var fire_frames = 0
const MAX_FIREFRAMES = 3
var fire_time = 0
const FIRE_RATE = 10

func _ready():
	Stats.Crosshair = self

func _process(delta):
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("fire") and fire_time == 0:
		fire_frames = MAX_FIREFRAMES
		fire_time = FIRE_RATE
	
	
	firing = (fire_frames > 0)
	fire_frames = max(0, fire_frames - 1)
	fire_time = max(0, fire_time - 1)
	
