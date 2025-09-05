extends Node
class_name SkillManager

enum Skills { ATTACK, BALL, WALLRUN, DROP_ATTACK, AIR_ATTACK }

static var is_air_attack_unlocked: bool = false
static var is_ball_unlcoked: bool = false

func _ready() -> void:
	AttackPlayerState.instance.enabled = false
	AttackPlayerState3D.instance.enabled = false
	ForrwardWallrunPlayerState.instance.enabled = false
	ForrwardWallrunPlayerState3D.instance.enabled = false
	SideWallrunPlayerState.instance.enabled = false
	DropAttackPlayerState.instance.enabled = false
	DropAttackPlayerState3D.instance.enabled = false
	AirAttackPlayerState.instance.enabled = false
	AirAttackPlayerState3D.instance.enabled = false


static func unlock_skill(skill: Skills) -> void:
	if skill == Skills.ATTACK:
		AttackPlayerState.instance.enabled = true
		AttackPlayerState3D.instance.enabled = true
	elif skill == Skills.BALL:
		is_ball_unlcoked = true
	elif skill == Skills.WALLRUN:
		ForrwardWallrunPlayerState.instance.enabled = true
		ForrwardWallrunPlayerState3D.instance.enabled = true
		SideWallrunPlayerState.instance.enabled = true
	elif skill == Skills.DROP_ATTACK:
		DropAttackPlayerState.instance.enabled = true
		DropAttackPlayerState3D.instance.enabled = true
	elif skill == Skills.AIR_ATTACK:
		is_air_attack_unlocked = true
		AirAttackPlayerState.instance.enabled = true
		AirAttackPlayerState3D.instance.enabled = true
