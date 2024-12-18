extends CharacterBody2D


const  SPEED = 200
const fly = -220.0

var can_fly := true

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if ray_cast_2d.is_colliding() and can_fly==true:
		velocity.y = fly
	var direction = Vector2.ZERO
	direction  =navigation_agent_2d.get_next_path_position() -global_position
	direction  = direction.normalized()
	velocity = velocity.lerp(direction*SPEED,delta)
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()





func _on_navigationtimer_timeout() -> void:
	navigation_agent_2d.target_position = player.global_position


func _on_fly_time_timeout() -> void:
	can_fly = true
