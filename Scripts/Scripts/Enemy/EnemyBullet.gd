class_name EnemyBullet
extends Node3D

var velocity: Vector3 = 10*Vector3.LEFT

func set_velocity(new_velocity: Vector3):
	velocity = new_velocity

func _physics_process(delta: float) -> void:
	position += delta * velocity

func _on_max_life_timer_timeout() -> void:
	queue_free()

func _on_bullet_hitbox_body_entered(body: Node3D) -> void:
	queue_free()
