# EnemyNormalState.gd
extends EnemyBaseState
class_name EnemyNormalState

func enter(_msg := {}):
	set_current_state(AIState.NORMAL)

func physics_update(delta: float):
	var target: Character = enemy.sensor_component.get_target()

	if target == null:
		return

	set_target(target)
	state_machine.change_state("State_Combat")
