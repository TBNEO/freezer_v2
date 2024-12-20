extends Node2D

@onready var pausable = $Pausable
@onready var freeze = $CanvasLayer/Freeze
@onready var hurt = $CanvasLayer/Hurt
@onready var audio_stream_player = $AudioStreamPlayer

func _process(delta):
	if Settings.Timefreeze_VFX:
		freeze.material.set("shader_parameter/Grayscale", Stats.Freeze)
	else:
		freeze.material.set("shader_parameter/Grayscale", false)
	if Settings.Hurt_VFX:
		hurt.material.set("shader_parameter/Hurt", Stats.hurt_vfx)
	else:
		hurt.material.set("shader_parameter/Hurt", 0.0)
	
	var last_freezetime = Stats.freeze_time
	Stats.freeze_time = max(0, Stats.freeze_time - 1)
	if last_freezetime > 0 and Stats.freeze_time == 0:
		audio_stream_player.volume_db = 1*Settings.SFX_Volume*float(Settings.SFX_Enabled)
		audio_stream_player.play()
		Stats.freeze_cd = Stats.MAX_FREEZE_CD
	
	Stats.Freeze = (Stats.freeze_time != 0)
	
	
	if Input.is_action_just_pressed("freeze") and Stats.freeze_cd == 0:
		audio_stream_player.play()
		Stats.freeze_time = Stats.MAX_FREEZE
	
	if Stats.freeze_time > 0:
		pausable.process_mode = Node.PROCESS_MODE_DISABLED
	elif Stats.freeze_time <= 0:
		pausable.process_mode = Node.PROCESS_MODE_INHERIT
	
	Stats.freeze_cd = max(0, Stats.freeze_cd - 1)
	


func _on_fps_checker_timeout() -> void:
	print(Engine.get_frames_per_second())
