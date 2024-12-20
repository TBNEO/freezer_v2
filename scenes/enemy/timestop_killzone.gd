extends Area2D

@onready var area = $area
@onready var sprite_2d = $Sprite2D

var mark_for_death := false

func _process(delta):
	if Input.is_action_just_pressed("fire") and Stats.Freeze:
		if area.shape.get_rect().has_point(get_local_mouse_position()):
			mark_for_death = true
			sprite_2d.visible = true
	
	if !Stats.Freeze and mark_for_death:
		mark_for_death = false
		owner.die()
