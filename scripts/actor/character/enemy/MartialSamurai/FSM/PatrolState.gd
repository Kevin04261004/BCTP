extends GroundEnemyBaseState

func physics_update(delta):

	movement_component.apply_gravity(delta)

	if (sensor_component.is_wall_detected() or not sensor_component.is_ground_detected()):

		movement_component.turn(
			-movement_component.facing_direction
		)

	movement_component.move(
		movement_component.facing_direction,
		root.stat_data.move_speed
	)

	movement_component.apply()

	if sensor_component.has_target():

		state_machine.change_state(
			"State_Chase",
			{
				"target": sensor_component.get_target()
			}
		)
