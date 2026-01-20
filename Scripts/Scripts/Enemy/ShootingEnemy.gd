class_name ShootingEnemy
extends Enemy

@export var bullet_scene: PackedScene
@export var bullet_spawn_marker: Marker3D

func _ready() -> void:
	speed = 0

func _on_timer_timeout() -> void:
	var bullet: EnemyBullet = bullet_scene.instantiate()
	bullet.position = bullet_spawn_marker.position
	get_parent().add_child(bullet)
