extends Node2D

var freeze_time = 0
var freeze_cd = 0

const MAX_FREEZE = 360
const MAX_FREEZE_CD = 10

@onready var pausable = $Pausable

func _process(delta):
	if Input.is_action_just_pressed("freeze") and freeze_cd == 0:
		freeze_time = MAX_FREEZE
	
	if freeze_time > 0:
		pausable.process_mode = Node.PROCESS_MODE_DISABLED
	elif freeze_time <= 0:
		pausable.process_mode = Node.PROCESS_MODE_INHERIT
	
	var last_freezetime = freeze_time
	freeze_time = max(0, freeze_time - 1)
	if last_freezetime > 0 and freeze_time == 0:
		freeze_cd = MAX_FREEZE_CD
	
	freeze_cd = max(0, freeze_cd - 1)
	


func _on_fps_checker_timeout() -> void:
	print(Engine.get_frames_per_second())
