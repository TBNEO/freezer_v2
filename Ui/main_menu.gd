extends Control

@onready var audio = $AudioStreamPlayer2D

func _on_start_button_down():
	audio.play()
	get_tree().change_scene_to_file("res://scenes/MAIN.tscn")


func _on_options_button_down():
	##do this eventually
	audio.play()
	pass


func _on_quit_button_down():
	audio.play()
	get_tree().quit()
