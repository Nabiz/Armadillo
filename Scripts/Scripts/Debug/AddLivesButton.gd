extends Button

func _on_pressed() -> void:
	PlayerManager.instance.gui.lose_hearts(-3)
