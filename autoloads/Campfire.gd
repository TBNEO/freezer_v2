extends Node

var Health := 25
const MAXHEALTH := 25

func _ready():
	Health = MAXHEALTH

func damage_campfire():
	Health -= 1
	Stats.StyleBoost = 1
	if Health <= 0:
		var campfirenode = get_tree().get_first_node_in_group("campfire")
		Stats.spawn_kill_fx(campfirenode.position)
		campfirenode.hide()
		await get_tree().create_timer(5.0).timeout
		get_tree().change_scene_to_file("res://Ui/gameover.tscn")
