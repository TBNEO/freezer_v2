extends Control

signal resume
signal paused
@onready var settings = $settings

func _on_resume_button_down():
	resume.emit()
	print("grah")

func _on_options_button_down():
	settings.show()
	settings.mouse_filter = MOUSE_FILTER_STOP

func _on_exit_to_title_button_down():
	get_tree().change_scene_to_file("res://Ui/main_menu.tscn")

func _process(delta):
	if !visible:
		if Input.is_action_just_pressed("pause"):
			paused.emit()
		else:
			return
	else:
		if Input.is_action_just_pressed("pause") and settings.visible:
			settings.hide()
			settings.mouse_filter = MOUSE_FILTER_PASS
		elif Input.is_action_just_pressed("pause") and !settings.visible:
			resume.emit()
