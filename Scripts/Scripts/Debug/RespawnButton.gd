extends Button

func _on_pressed() -> void:
	SpawnManager.instance.spawn_player(Player.instance)
