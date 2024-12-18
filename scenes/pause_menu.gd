extends Control

signal resume

func _on_resume_button_down():
	resume.emit()


func _on_options_button_down():
	pass # Replace with function body.


func _on_exit_to_title_button_down():
	get_tree().change_scene_to_file("res://Ui/main_menu.tscn")
