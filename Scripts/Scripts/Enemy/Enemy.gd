class_name Enemy
extends CharacterBody3D

var health: int = 3

var max_ticks: int = 150
var ticks: int = 0
@export var speed: float = 2

func _physics_process(delta: float) -> void:
	ticks+=1
	if ticks == max_ticks:
		speed*=-1
		ticks=0
	velocity.x = speed
	velocity+=get_gravity() * delta
	move_and_slide()
