extends Node

enum Skills { ATTACK, BALL, WALLRUN, DROP_ATTACK, AIR_ATTACK }

var is_air_attack_unlocked: bool = false
var is_ball_unlcoked: bool = false

func _ready() -> void:
	AttackPlayerState.instance.enabled = false
	AttackPlayerState3D.instance.enabled = false
	ForrwardWallrunPlayerState.instance.enabled = false
	DropAttackPlayerState.instance.enabled = false
	DropAttackPlayerState3D.instance.enabled = false
	AirAttackPlayerState.instance.enabled = false
	AirAttackPlayerState3D.instance.enabled = false


func unlock_skill(skill) -> void:
	if skill == Skills.ATTACK:
		AttackPlayerState.instance.enabled = true
		AttackPlayerState3D.instance.enabled = true
	elif skill == Skills.BALL:
		is_ball_unlcoked = true
	elif skill == Skills.WALLRUN:
		ForrwardWallrunPlayerState.instance.enabled = true
	elif skill == Skills.DROP_ATTACK:
		DropAttackPlayerState.instance.enabled = true
		DropAttackPlayerState3D.instance.enabled = true
	elif skill == Skills.AIR_ATTACK:
		is_air_attack_unlocked = true
		AirAttackPlayerState.instance.enabled = true
		AirAttackPlayerState3D.instance.enabled = true
