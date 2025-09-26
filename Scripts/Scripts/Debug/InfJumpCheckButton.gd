extends CheckButton

func _process(_delta: float) -> void:
	if button_pressed:
		JumpPlayerState.instance.reset_jump()
		JumpPlayerState3D.instance.reset_jump()
		
