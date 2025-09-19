extends CheckButton


func _on_toggled(toggled_on: bool) -> void:
	if !Player.instance.is_ball:
		if toggled_on:
			Player.instance._change_movement_strategy_to_3d()
		else:
			Player.instance._change_movement_strategy_to_2d()
