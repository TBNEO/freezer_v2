extends Node2D

@onready var audio = $AudioStreamPlayer2D
@onready var particles = $GPUParticles2D

func _ready():
	audio.play()
	particles.restart()

func erase() -> void:
	queue_free()
