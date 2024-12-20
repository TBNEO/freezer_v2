extends CharacterBody2D

var SPEED :int= 100
var dmg:float
var knockback : Vector2






@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


@onready var attack_timer = $Timer
@onready var campfire =get_tree().get_first_node_in_group("campfire")

var randomnum

enum {
	SURROUND,
	ATTACK,
	HIT,
}

var state = SURROUND

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	

	

func _physics_process(delta):
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)
		ATTACK:
			move(campfire.global_position, delta)
		HIT:
			move(campfire.global_position, delta)
			knockback = knockback.move_toward(Vector2(10,10),10)
			velocity += knockback
			var collider = move_and_collide(velocity * delta)
			if collider:
				collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * 50
			print("HIT")
			#Slash ANIM

func move(target, delta):
	var direction = (target - global_position).normalized() 
	var desired_velocity =  direction * SPEED
	var steering = (desired_velocity - velocity) * delta * 10
	velocity += steering
	move_and_slide()
#	if direction.x<0:
#		animated_sprite.flip_h = true
	#elif direction.x>0:
	#	animated_sprite.flip_h = false
func get_circle_position(random):
	var kill_circle_centre = campfire.global_position
	var radius = 40
	var angle = random * PI * 2;
	var x = kill_circle_centre.x + cos(angle) * radius;
	var y = kill_circle_centre.y + sin(angle) * radius;

	return Vector2(x, y)


func die():
	Stats.style_add(10)
	Stats.StyleBoost += 1
	Stats.StyleDecay = Stats.MAX_STYLEDECAY
	Stats.spawn_kill_fx(global_position)
	queue_free()



func _on_timer_timeout() -> void:
	state = ATTACK
