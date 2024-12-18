extends Node2D


@export var enemy_spawner_node = preload("res://scenes/enemy/nav_enemy.tscn")

var spawn_enemies := []

@export var spawn_points : Array [Marker2D]
@onready var main = get_tree().get_first_node_in_group("main")
@export var num = 10
@onready var timer = $Timer
var spawns := 0:
	set(value):
		if value == num:
			timer.stop()
		else:
			spawns = value
			timer.start()

var can_spawn : bool = true
func _process(delta):
			for i in get_children():
				if i is Marker2D:
					spawn_enemies.append(i)




func _on_timer_timeout():
	var spawn = spawn_enemies[randi()% spawn_enemies.size()]
	var enemi = enemy_spawner_node.instantiate()
	enemi.position = spawn.position
	main.add_child(enemi)
	#enemi.died.connect(on_enemy_died)
	spawns += 1
	var en_node = get_tree().get_nodes_in_group("spawn")
	#var node = en_node[randi()% en_node.size()]
	



func on_enemy_died(enemy):
	spawns -= 1
	spawn_enemies.erase(spawn_enemies)
