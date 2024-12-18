extends Node2D

var firing = false
var fire_time = 0
const FIRE_RATE = 3

func _ready():
	Stats.Crosshair = self

func _physics_process(delta):
	global_position = get_global_mouse_position()
	
	firing = false
	
	if Input.is_action_just_pressed("fire") and not firing and fire_time == 0:
		firing = true
		fire_time = FIRE_RATE
	
	fire_time = max(0, fire_time - 1)
	
