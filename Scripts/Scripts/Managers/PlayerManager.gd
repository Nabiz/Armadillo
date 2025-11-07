class_name PlayerManager
extends Node3D

@export var gui: GUI
@export var player: Player
@export var player_ball: PlayerBall

static var instance: PlayerManager

func _enter_tree() -> void:
	instance = self

func take_damage(ammount: int) -> void:
	gui.lose_hearts(ammount)
	if gui.hearts <= 0:
		GameOverScreen.instance.show_gameover()
		SpawnManager.instance.spawn_player(player)
