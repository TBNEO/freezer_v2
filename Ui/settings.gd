extends NinePatchRect

@onready var volumeslider = $VBoxContainer/Volume_SFX/HSlider
@onready var musicslider = $VBoxContainer/Volume_MUSIC/HSlider
@onready var audio = $AudioStreamPlayer2D


func _on_sfx_volume_drag_ended(value_changed):
	Settings.SFX_Volume = volumeslider.value/10

func _on_music_drag_ended(value_changed):
	Settings.Music_Volume = musicslider.value/10

func _on_volume_toggle_toggled(toggled_on):
	if Settings.SFX_Enabled:
		audio.play()
	Settings.SFX_Enabled = toggled_on

func _on_music_toggle_toggled(toggled_on):
	if Settings.SFX_Enabled:
		audio.play()
	Settings.Music_Enabled = toggled_on

func _on_freeze_vfx_toggle_toggled(toggled_on):
	if Settings.SFX_Enabled:
		audio.play()
	Settings.Timefreeze_VFX = toggled_on

func _on_hurt_vfx_toggle_toggled(toggled_on):
	if Settings.SFX_Enabled:
		audio.play()
	Settings.Hurt_VFX = toggled_on
