extends Control

@onready var texture_progress_bar = $TextureProgressBar
@onready var sprite_2d = $Sprite2D

func _process(delta):
	if Stats.Freeze:
		texture_progress_bar.max_value = Stats.MAX_FREEZE
		texture_progress_bar.value = Stats.freeze_time
	else:
		texture_progress_bar.max_value = Stats.MAX_FREEZE_CD
		texture_progress_bar.value = Stats.MAX_FREEZE_CD - Stats.freeze_cd
	if texture_progress_bar.value == texture_progress_bar.max_value:
		sprite_2d.show()
	else:
		sprite_2d.hide()
