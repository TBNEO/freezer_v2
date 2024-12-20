extends CharacterBody2D


var jump_timer = true
var JUMP_VELOCITY = -400
var SPEED = 200
@onready var animation_player: AnimationPlayer =$AnimationPlayer
@onready var left: RayCast2D = $RayCast2D
@onready var right: RayCast2D = $RayCast2D2
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var explod = $AnimatedSprite2D
@onready var explode_sprite = $explod
@onready var particles = $CPUParticles2D
@onready var audio = $AudioStreamPlayer2D

@onready var player = get_tree().get_first_node_in_group("player")

var locked: bool = false

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if locked: 
		move_and_slide()
		return
	
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
				animation_player.play("run")
			
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
		#velocity.x = 0.0
	
	move_and_slide()
	
	


func _on_jump_timer_timeout() -> void:
	jump_timer = true
	print(jump_timer)

func die():
	Stats.style_add(50)
	Stats.StyleBoost += 1
	Stats.StyleDecay = Stats.MAX_STYLEDECAY
	Stats.spawn_kill_fx(global_position)
	queue_free()

func _on_explode_detect_body_entered(body: Node2D) -> void:
	explod.hide()
	explode_sprite.show()
	velocity.x = 0.0
	locked = true
	move_and_slide()
	await get_tree().create_timer(1.0).timeout
	animation_player.play("explode")
	await animation_player.animation_finished
	particles.restart()
	audio.play()
	if global_position.distance_to(body.global_position) < 75:
		Stats.take_damage()
	self.hide()
	await audio.finished
	queue_free()

func _on_navigation_timer_timeout() -> void:
	navigation_agent_2d.target_position = player.global_position
