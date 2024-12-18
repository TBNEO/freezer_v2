extends Control

@onready var campfire_health = $HBoxContainer/TextureProgressBar
@onready var health = $HBoxContainer/TextureProgressBar2

func _process(delta):
	campfire_health.max_value = Campfire.MAXHEALTH
	campfire_health.value = Campfire.Health
	
	health.max_value = Stats.MAXHEALTH
	health.value = Stats.Health
	
