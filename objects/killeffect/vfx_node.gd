extends Node2D

@onready var audio = $AudioStreamPlayer2D
@onready var particles = $GPUParticles2D

func _ready():
	audio.volume_db = Settings.SFX_Volume
	if Settings.SFX_Enabled and Settings.SFX_Volume > 0:
		audio.play()
	particles.restart()

func erase() -> void:
	queue_free()
