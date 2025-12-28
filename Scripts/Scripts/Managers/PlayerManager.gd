class_name PlayerManager
extends Node3D

@export var gui: GUI
@export var player: Player
@export var player_ball: PlayerBall
@export var iframe_timer: Timer

var is_ball: bool = false

var material: Material = load("res://Resources/IframeMaterial.tres")

static var instance: PlayerManager

func _enter_tree() -> void:
	instance = self

func take_damage(ammount: int, knockback_velocity: Vector3) -> void:
	gui.lose_hearts(ammount)
	if player.is_ball:
		player_ball.set_hitbox_collsion_disabled(true)
		player_ball.velocity = knockback_velocity
		player_ball.gfx_sphere.get_node("Mesh").set_surface_override_material(0, material)
	else:
		player.set_hitbox_collsion_disabled(true)
		if player.is_movment3D:
			player.state_machine.transit_to_new_state(KnockbackPlayerState3D.instance)
		else:
			player.state_machine.transit_to_new_state(KnockbackPlayerState.instance)
		player.velocity = knockback_velocity
		player.gfx.get_node("Armature/Skeleton3D/input").set_surface_override_material(0, material)
	
	iframe_timer.start()
	if gui.hearts <= 0:
		GameOverScreen.instance.show_gameover()
		SpawnManager.instance.spawn_player(player)

func _on_iframe_timer_timeout() -> void:
	if player.is_ball:
		player_ball.set_hitbox_collsion_disabled(false)
	else:
		player.set_hitbox_collsion_disabled(false)
	player.gfx.get_node("Armature/Skeleton3D/input").set_surface_override_material(0, null)
	player_ball.gfx_sphere.get_node("Mesh").set_surface_override_material(0, null)
	
