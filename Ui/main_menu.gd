extends Control

@onready var audio = $Clicksound
@onready var settings = $settings
@onready var menu_theme = $MenuTheme

func _process(delta):
	if !Settings.Music_Enabled:
		menu_theme.stop()
	else:
		if !menu_theme.playing:
			menu_theme.play()

func _on_start_button_down():
	if Settings.SFX_Enabled:
		audio.play()
	get_tree().change_scene_to_file("res://scenes/MAIN.tscn")

func _on_options_button_down():
	settings.show()
	if Settings.SFX_Enabled:
		audio.play()
	pass

func _on_quit_button_down():
	if Settings.SFX_Enabled:
		audio.play()
	get_tree().quit()

func _unhandled_input(event):
	if Input.is_action_just_pressed("pause"):
		settings.hide()

func _on_menu_theme_finished():
	menu_theme.play()
