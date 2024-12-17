extends Node

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var main = $MAIN

func _ready():
	pause_menu.resume.connect(unpause_game)
	

func _unhandled_input(event):
	if Input.is_action_just_pressed("pause"):
		match main.process_mode:
			Node.PROCESS_MODE_INHERIT:
				pause_game()
			Node.PROCESS_MODE_DISABLED:
				unpause_game()
			

func pause_game():
	main.process_mode = Node.PROCESS_MODE_DISABLED
	pause_menu.visible = true

func unpause_game():
	main.process_mode = Node.PROCESS_MODE_INHERIT
	pause_menu.visible = false
