extends Node2D
@onready var music = $AudioStreamPlayer2D

func _process(delta):
	if !Settings.Music_Enabled:
		music.stop()
	else:
		if !music.playing:
			music.play()


func _on_audio_stream_player_2d_finished():
	music.play()
