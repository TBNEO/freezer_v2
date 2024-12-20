extends CharacterBody2D


var jump_timer = true
var JUMP_VELOCITY = -400
var SPEED = 100
@onready var animation_player: AnimationPlayer =$AnimationPlayer
@onready var left: RayCast2D = $RayCast2D
@onready var right: RayCast2D = $RayCast2D2
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var explod = $AnimatedSprite2D

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if right.is_colliding()and jump_timer == true:
		#animation_player.play("jump")
		velocity.y = JUMP_VELOCITY
		jump_timer=false
	elif left.is_colliding() and jump_timer == true :
		#animation_player.play("jump")
		velocity.y = JUMP_VELOCITY
		jump_timer=false
	else:
		if is_on_floor():
			if global_position.distance_to(navigation_agent_2d.target_position) > 30:
				animation_player.play("walk")
			else:
				if animation_player.current_animation != "idle" and animation_player.current_animation != "atk":
					animation_player.play("idle")

	var direction = Vector2.ZERO
	direction  = global_position.direction_to(navigation_agent_2d.get_next_path_position())
	velocity = velocity.lerp(direction*SPEED,delta)
	#animated_sprite_2d.play("run")
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = lerpf(velocity.x, 0.0, 0.2)
	if direction.x >0:
		explod.flip_h= true
	elif direction.x <0:
		explod.flip_h=false
	
	#if global_position.distance_to(navigation_agent_2d.target_position) < 30.0 and campfire_attack.is_stopped():
		#campfire_attack.start()
		velocity.x = 0.0
	
	move_and_slide()
	
	


func _on_jump_timer_timeout() -> void:
	jump_timer = true
	print(jump_timer)

func _die():
	queue_free()

func _on_explode_detect_body_entered(body: Node2D) -> void:
	explod.stop()
	if body.is_in_group("player"):
		animation_player.play("explode")


func _on_navigation_timer_timeout() -> void:
	navigation_agent_2d.target_position = player.global_position
