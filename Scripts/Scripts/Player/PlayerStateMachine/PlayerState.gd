extends Node
class_name PlayerState

@warning_ignore("unused_signal")
signal state_changing(new_state: PlayerState)

var player_state_machine: PlayerStateMachine
var player: Player

var enabled: bool = true

func _ready() -> void:
	player_state_machine = get_parent() as PlayerStateMachine
	player = player_state_machine.player

func handle_input(_event: InputEvent) -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
