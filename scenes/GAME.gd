extends Node

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var main = $MAIN

func pause_game():
	main.process_mode = Node.PROCESS_MODE_DISABLED
	pause_menu.visible = true

func unpause_game():
	main.process_mode = Node.PROCESS_MODE_INHERIT
	pause_menu.visible = false
