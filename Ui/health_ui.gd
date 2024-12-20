extends Control
@onready var campfire = $HBoxContainer/TextureProgressBar
@onready var health = $HBoxContainer/TextureProgressBar2

func _process(delta):
	campfire.max_value = Campfire.MAXHEALTH
	campfire.value = Campfire.Health
	
	health.max_value = Stats.MAXHEALTH
	health.value = Stats.Health
	
