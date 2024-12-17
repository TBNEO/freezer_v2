extends Control



func _on_start_button_down():
	get_tree().change_scene_to_file("res://scenes/MAIN.tscn")


func _on_options_button_down():
	##do this eventually
	pass


func _on_quit_button_down():
	get_tree().quit()
