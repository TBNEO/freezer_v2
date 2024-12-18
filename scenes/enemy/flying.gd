extends CharacterBody2D

const  SPEED = 100
const fly = -200.0

var can_fly := true

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

@onready var target = get_tree().get_first_node_in_group("campfire")

func _physics_process(delta: float) -> void:
	if ray_cast_2d.is_colliding() and can_fly==true:
		velocity.y = fly
	var direction = Vector2.ZERO
	direction = global_position.direction_to(navigation_agent_2d.target_position)
	velocity = velocity.lerp(direction*SPEED,delta)
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.lerp(Vector2.ZERO, 0.2)

	move_and_slide()

func _on_navigationtimer_timeout() -> void:
	if navigation_agent_2d.distance_to_target() > 10.0:
		var dir = signf(global_position.direction_to(target.global_position).x)
		navigation_agent_2d.target_position = target.global_position+Vector2(20 * dir, 220.0)
	

func _on_fly_time_timeout() -> void:
	can_fly = true

func die():
	queue_free()
