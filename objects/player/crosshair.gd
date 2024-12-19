extends Node2D

var firing = false
var fire_frames = 0
const MAX_FIREFRAMES = 3
var fire_time = 0
const FIRE_RATE = 10

func _ready():
	Stats.Crosshair = self

func _process(delta):
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("fire") and fire_time == 0:
		fire_frames = MAX_FIREFRAMES
		fire_time = FIRE_RATE
		bullet_trail()
	
	
	firing = (fire_frames > 0)
	fire_frames = max(0, fire_frames - 1)
	fire_time = max(0, fire_time - 1)



func bullet_trail() -> void:
	if Stats.Freeze: return
	var player = get_tree().get_first_node_in_group("player").global_position
	var t = get_tree().create_tween()
	var trail = Line2D.new()
	trail.global_position = player
	trail.points = [Vector2.ZERO, trail.global_position.direction_to(global_position)*500]
	trail.default_color = Color.LIGHT_YELLOW
	trail.width = 2
	get_tree().root.add_child(trail)
	t.tween_property(trail, "default_color", Color.TRANSPARENT, 1.0)
	await t.finished
	trail.queue_free()
