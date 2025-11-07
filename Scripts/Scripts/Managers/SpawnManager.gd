extends Node
class_name SpawnManager

var spawn_points: Array[Marker3D]
var current_spawn_point: Marker3D
static var instance: SpawnManager

func _enter_tree() -> void:
	instance = self

func _ready() -> void:
	for child: Marker3D in get_children():
		var spawn_point: Marker3D = child
		spawn_points.append(spawn_point)
	if len(spawn_points) > 0:
		current_spawn_point = spawn_points[0]

func spawn_player(player: Player) -> void:
		player.global_position = current_spawn_point.global_position
		player.player_ball.global_position = current_spawn_point.global_position
		PlayerManager.instance.gui.lose_hearts(-3)
