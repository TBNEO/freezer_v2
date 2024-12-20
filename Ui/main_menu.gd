extends Control

@onready var audio = $AudioStreamPlayer2D
@onready var settings = $settings

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
