extends Area2D


##Invincibility Frames
var MAXIVTime := 30
var IVTime := 0

var KBMultiplier := 100.0

@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	body_entered.connect(take_damage)

func _process(delta):
	var last_ivtime = IVTime
	if IVTime > 0:
		IVTime -= 1
	if last_ivtime > 0 and IVTime == 0:
		collision_shape_2d.disabled = false

func take_damage(body: PhysicsBody2D) -> void:
	Stats.take_damage()
	owner.velocity = owner.global_position.direction_to(body.global_position)*KBMultiplier
	IVTime = MAXIVTime
	collision_shape_2d.call_deferred("set_disabled", true)
