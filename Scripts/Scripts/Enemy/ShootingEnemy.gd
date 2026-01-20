class_name ShootingEnemy
extends Enemy

@export var bullet_scene: PackedScene

func _ready() -> void:
	speed = 0

func _on_timer_timeout() -> void:
	var bullet: EnemyBullet = bullet_scene.instantiate()
	bullet.position = $Marker3D.position
	get_parent().add_child(bullet)
