extends CharacterBody3D
class_name Enemy

var is_seeking_to_player: bool = false 
@export var gfx: Node3D

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	if is_seeking_to_player:
		seek_to_player(delta)
	else:
		velocity.x = 0
	move_and_slide()

func seek_to_player(delta: float) -> void:
	var direction: int = sign(Player.instance.global_position.x - global_position.x)
	velocity.x = 100 * direction * delta
	
	if direction < 0:
		gfx.rotation.y = 1.5*PI
	else:
		gfx.rotation.y = 0.5*PI

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player or body is PlayerBall:
		is_seeking_to_player = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player or body is PlayerBall:
		is_seeking_to_player = false
