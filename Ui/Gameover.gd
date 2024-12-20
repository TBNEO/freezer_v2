extends Control

func _ready():
	$TextureRect/VBoxContainer/Label.text = "Score: " + str(Stats.Style)
	if Stats.Health <= 0:
		$TextureRect/VBoxContainer/Label2.text = "Cause: Killed"
	elif Campfire.Health <= 0:
		$TextureRect/VBoxContainer/Label2.text = "Cause: Campfire Went out"

func _on_texture_button_button_down():
	get_tree().change_scene_to_file("res://Ui/main_menu.tscn")
	Stats.Health = Stats.MAXHEALTH
	Campfire.Health = Campfire.MAXHEALTH
