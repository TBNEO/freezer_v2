extends Node2D

@onready var pausable = $Pausable

func _process(delta):
	
	var last_freezetime = Stats.freeze_time
	Stats.freeze_time = max(0, Stats.freeze_time - 1)
	if last_freezetime > 0 and Stats.freeze_time == 0:
		Stats.freeze_cd = Stats.MAX_FREEZE_CD
	
	Stats.Freeze = (Stats.freeze_time != 0)
	
	if Input.is_action_just_pressed("freeze") and Stats.freeze_cd == 0:
		Stats.freeze_time = Stats.MAX_FREEZE
	
	if Stats.freeze_time > 0:
		pausable.process_mode = Node.PROCESS_MODE_DISABLED
	elif Stats.freeze_time <= 0:
		pausable.process_mode = Node.PROCESS_MODE_INHERIT
	
	Stats.freeze_cd = max(0, Stats.freeze_cd - 1)
	


func _on_fps_checker_timeout() -> void:
	print(Engine.get_frames_per_second())
