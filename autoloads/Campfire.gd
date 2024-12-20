extends Node

var Health := 25
const MAXHEALTH := 25

signal DEFENSE_FAIL

func damage_campfire():
	Health -= 1
	Stats.StyleBoost = 1
	if Health <= 0:
		var campfirenode = get_tree().get_first_node_in_group("campfire")
		Stats.spawn_kill_fx(campfirenode.position)
		campfirenode.hide()
