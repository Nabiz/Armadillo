extends Node
class_name PlayerStateMachine

@export var current_state: PlayerState
@export var player: Player

func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)
	player.move_and_slide()

func transit_to_new_state(new_state: PlayerState) -> void:
	if new_state.enabled:
		current_state.exit()
		current_state = new_state
		current_state.enter()
