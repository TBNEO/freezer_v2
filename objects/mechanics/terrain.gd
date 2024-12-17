extends StaticBody2D

func _process(delta):
	if Input.is_action_pressed("down"):
		$platformA.disabled = true
		$platformB.disabled = true
	else:
		$platformA.disabled = false
		$platformB.disabled = false
