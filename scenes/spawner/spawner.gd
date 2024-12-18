extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")


var distance = 300

var enemy_node_A = preload("res://scenes/enemy/nav_enemy.tscn")
var enemy_node_B = preload("res://scenes/enemy/nav_enemy.tscn")
var enemy_node_C = preload("res://scenes/enemy/flying.tscn")
var can_spawn_A =  true
var can_spawn_B =  true
var can_spawn_C = true



@export var can_spawn_a = true
@export var can_spawn_b = true
@export var can_spawn_c = true





func spawn_a(pos : Vector2):
	#if can_spawn_A == true and stop_spawn == false:
	if can_spawn_a == true:
		var enemy = enemy_node_A.instantiate()
		add_child(enemy)
		can_spawn_A = false
		enemy.position = pos


func spawn_b(pos : Vector2):
	#if can_spawn_B == true and stop_spawn_B == false:
	if can_spawn_b == true:
		var enemy_B = enemy_node_B.instantiate()
		add_child(enemy_B)
		can_spawn_B = false
		enemy_B.position = pos
func spawn_C(pos : Vector2):
	#if can_spawn_B == true and stop_spawn_B == false:
	if can_spawn_c == true:
		var enemy_C = enemy_node_C.instantiate()
		add_child(enemy_C)
		can_spawn_C = false
		var chance = randi()%7
		match chance :
			0: 
				enemy_C.position = Vector2(300,0)
			1:
				enemy_C.position = Vector2(200,0)
			2:
				enemy_C.position = Vector2(100,0)
			3:
				enemy_C.position = Vector2(-100,0)
			4:
				enemy_C.position = Vector2(400,0)
			5:
				enemy_C.position = Vector2(500,0)
			6:
				enemy_C.position = Vector2(0,0)






func spawn_pos():
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(500,-500 ))
	
	
func _on_timer_timeout() -> void:
	can_spawn_A = true
	spawn_a(spawn_pos())
	#number_of_spawned +=1
	
	


func _on_timerb_timeout() -> void:
	can_spawn_B = true
	#spawn_b(spawn_pos())


func _on_boss_timer_timeout() -> void:
	can_spawn_C = true
	spawn_C(spawn_pos())


func _on_a_timeout() -> void:
	can_spawn_A = true
	spawn_a(spawn_pos())


func _on_b_timeout() -> void:
	can_spawn_B = true
	spawn_b(spawn_pos())


func _on_c_timeout() -> void:
	can_spawn_C = true
	spawn_C(spawn_pos())
