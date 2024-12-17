extends Control

@onready var style = $ColorRect/VBoxContainer/Style
@onready var style_combo = $ColorRect/VBoxContainer/Style_Combo

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Stats.is_node_ready(): return
	style.text = "STYLE: " + str(Stats.Style)
	style_combo.text = "MULTIPLIER: " + str(Stats.StyleBoost)
	
