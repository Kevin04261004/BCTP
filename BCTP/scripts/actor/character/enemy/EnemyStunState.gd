# EnemyStunState.gd
extends EnemyBaseState
class_name EnemyStunState

# TODO: 외부에서 Stun_duration넣을 수 있
@export var stun_duration: float = 1.0

var stun_timer: float = 0.0

func enter(_msg := {}):
	set_current_state(AIState.STUN)

	stun_timer = 0.0
	enemy.movement_component.stop_all()

	enemy.animation_component.play_state("stun")

func physics_update(delta: float):
	stun_timer += delta

	enemy.movement_component.apply_gravity(delta)
	enemy.movement_component.apply()

	if stun_timer < stun_duration:
		return

	state_machine.change_state("State_Combat")
