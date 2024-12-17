extends Node2D

func _ready():
	Stats.Crosshair = self

func _physics_process(delta):
	global_position = get_global_mouse_position()
