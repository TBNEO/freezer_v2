extends Node2D

@onready var audio = $AudioStreamPlayer2D
@onready var particles = $GPUParticles2D

func _ready():
	audio.volume_db = Settings.SFX_Volume*float(Settings.SFX_Enabled)
	audio.play()
	particles.restart()

func erase() -> void:
	queue_free()
