extends CharacterBody2D




@export var jump_timer =true


const  SPEED = 100
const JUMP_VELOCITY = -700.0


@onready var right: RayCast2D = $right
@onready var left: RayCast2D = $left

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

@onready var campfire = get_tree().get_first_node_in_group("campfire")
@onready var campfire_attack = $campfire_attack

func _physics_process(delta: float) -> void:
	if navigation_agent_2d.distance_to_target() < 10.0 and campfire_attack.is_stopped():
		campfire_attack.start()
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if right.is_colliding()and jump_timer == true:
		velocity.y = JUMP_VELOCITY
		jump_timer=false
	if left.is_colliding() and jump_timer == true :
		velocity.y = JUMP_VELOCITY
		jump_timer=false


	var direction = Vector2.ZERO
	direction  = global_position.direction_to(navigation_agent_2d.get_next_path_position())
	velocity = velocity.lerp(direction*SPEED,delta)
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = lerpf(velocity.x, 0.0, 0.2)

	move_and_slide()
	
	

func _on_navigationtimer_timeout() -> void:
	navigation_agent_2d.target_position = campfire.global_position

func _on_jump_timer_timeout() -> void:
	jump_timer = true

func die():
	Stats.style_add(10)
	Stats.StyleBoost += 1
	Stats.StyleDecay = Stats.MAX_STYLEDECAY
	queue_free()

func _on_campfire_attack_timeout():
	Campfire.damage_campfire()
