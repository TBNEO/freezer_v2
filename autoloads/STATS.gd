extends Node

const VFX_NODE = preload("res://objects/killeffect/vfx_node.tscn")

var Health := 10.0
const MAXHEALTH := 10.0
var Healthlock := 0.0

var Style := 0
var StyleBoost := 1
var StyleDecay := 240
const MAX_STYLEDECAY = 240

var Crosshair
var audio_node : AudioStreamPlayer2D

var Freeze := false

const MAX_FREEZE = 180
const MAX_FREEZE_CD = 360

var freeze_time = 0
var freeze_cd = 0

var hurt_vfx = 0.0

func _init():
	process_priority = -1

func _ready():
	audio_node = AudioStreamPlayer2D.new()
	audio_node.stream = load("res://assets/sounds/hit.wav")
	add_child(audio_node)

func style_add(amount: int):
	Style += amount * StyleBoost

func take_damage():
	audio_node.volume_db = 1*Settings.SFX_Volume*float(Settings.SFX_Enabled)
	audio_node.play()
	hurt_vfx = 1.0
	StyleBoost = 1
	Health -= 1
	if Health <= 0:
		audio_node.stream = load("res://assets/sounds/playerdead.wav")
		audio_node.play()
		var player = get_tree().get_first_node_in_group("player")
		player.hide()
		player.process_mode = Node.PROCESS_MODE_DISABLED
		spawn_kill_fx(player.global_position)

func _process(delta):
	hurt_vfx = max(0, hurt_vfx - delta)
	
	if Freeze: return
	if StyleBoost > 1:
		if StyleDecay > 0:
			StyleDecay -= 1
		else:
			StyleBoost -= 1

func spawn_kill_fx(pos: Vector2) -> void:
	var vfx = VFX_NODE.instantiate()
	get_tree().root.add_child(vfx)
	vfx.position = pos
	
