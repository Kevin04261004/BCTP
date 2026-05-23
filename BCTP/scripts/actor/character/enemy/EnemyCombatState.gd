# EnemyCombatState.gd
extends EnemyBaseState
class_name EnemyCombatState

func enter(_msg := {}):
	set_current_state(AIState.COMBAT)

func physics_update(delta: float):
	var target: Character = enemy.sensor_component.get_target()

	set_target(target)

	if target != null:
		return

	state_machine.change_state("State_Normal")
