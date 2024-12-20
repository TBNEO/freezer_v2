extends NinePatchRect

func _on_volume_toggle_button_down():
	Settings.SFX_Enabled = $"VBoxContainer/Volume_SFX/Volume Toggle".button_pressed

func _on_music_toggle_button_down():
	Settings.Music_Enabled = $"VBoxContainer/Volume_MUSIC/Music Toggle".button_pressed

func _on_freeze_vfx_toggle_button_down():
	Settings.Timefreeze_VFX = $"VBoxContainer/Toggle_FreezeFX/FreezeVFX Toggle".button_pressed

func _on_hurt_vfx_toggle_button_down():
	Settings.Hurt_VFX = $"VBoxContainer/Toggle_HurtFX/HurtVFX Toggle".button_pressed

func _on_sfx_volume_drag_ended(value_changed):
	if !value_changed: return
	Settings.SFX_Volume = $VBoxContainer/Volume_SFX/HSlider.value/100

func _on_music_drag_ended(value_changed):
	if !value_changed: return
	Settings.Music_Volume = $VBoxContainer/Volume_Music/HSlider.value/100
