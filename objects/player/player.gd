extends CharacterBody2D

const SPEED = 300.0
const DASHSPEED = 1000.0
const JUMP_VELOCITY = -500.0
const ACCELERATION = 0.75
const AIR_ACCEL = 0.1

var dash_buffer = 0
const MAXDASHBUFFER = 6
var dashtime = 0
const MAXDASHTIME = 3
var dash_cd = 0
const MAXDASHCD = 50

var jump_buffer = 0
const MAXJUMPBUFFER = 6

var mousedir = Vector2.LEFT

@export_category("Camera Shake Settings")
@export var time:float = 1
@export var power:float = 1


@onready var ray_cast_2d = $RayCast2D
@onready var score_display = $CanvasLayer/Control
@onready var camera = get_tree().get_first_node_in_group("camera")
@onready var anims = $Anims/AnimationPlayer
@onready var gun = $RayCast2D/gun

func _process(delta):
	if Stats.is_node_ready():
		ray_cast_2d.enabled = Stats.Crosshair.firing
		ray_cast_2d.target_position = global_position.direction_to(Stats.Crosshair.global_position)*500
		
		if ray_cast_2d.is_colliding():
			if ray_cast_2d.get_collider():#.has_method("die"):
				ray_cast_2d.get_collider().die()
				camera.shake(time,power)
		
	var last_dashtime = dashtime
	buffer_process()
	if last_dashtime > 0 and dashtime == 0:
		velocity /= 2

func _physics_process(delta):
	velocity = movement_process(velocity)
	var was_aired = !is_on_floor()
	move_and_slide()
	if (was_aired and is_on_floor()):
		anims.play("land")
		return
	anim_manager()

func buffer_process() -> void:
	if Input.is_action_just_pressed("dash") and dash_cd == 0:
		dash_buffer = MAXDASHBUFFER
		mousedir = global_position.direction_to(get_global_mouse_position())
	else:
		dash_buffer = max(0, dash_buffer-1)
	
	dashtime = max(0, dashtime-1)
	dash_cd = max(0, dash_cd-1)
	if Input.is_action_just_pressed("jump"):
		jump_buffer = MAXJUMPBUFFER
	else:
		jump_buffer = max(0, jump_buffer-1)

func movement_process(v: Vector2) -> Vector2:
	var ac = ACCELERATION if is_on_floor() else AIR_ACCEL
	var direction = Input.get_axis("left", "right")
	var speed = SPEED * direction
	
	if dash_buffer > 0 and dash_cd == 0:
		dashtime = MAXDASHTIME
	
	if dashtime > 0:
		v = mousedir * DASHSPEED
		dash_cd = MAXDASHCD
	else:
		if jump_buffer > 0 and is_on_floor():
			v.y = JUMP_VELOCITY
		elif Input.is_action_just_released("jump") and v.y < 0:
			v.y /= 2
		
		if not is_on_floor():
			v += get_gravity() * get_physics_process_delta_time()
		
		if direction:
			v.x = lerpf(v.x, speed, ac)
		else:
			v.x = lerpf(v.x, 0.0, ac/2)
		
	return v
	

func anim_manager():
	$Sprite2D.flip_h = sign(global_position.direction_to(get_global_mouse_position()).x) < 0
	gun.look_at(get_global_mouse_position())
	gun.flip_v = sign(global_position.direction_to(get_global_mouse_position()).x) < 0
	var current = anims.current_animation
	if current == "land": return
	if current == "dash": await anims.animation_finished
	if is_on_floor():
		if dashtime == 0:
			var input = Input.get_axis("left", "right")
			if input == 0.0:
				anims.play("idle")
				return
			else:
				anims.play("walk")
				return
	else:
		if velocity.y < 0 and not dashtime:
			anims.play("jump")
			return
		anims.play("air")
		return
	if dashtime != 0:
		anims.play("dash")
		return
