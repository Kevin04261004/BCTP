# MoveState.gd
extends HeroBaseState

func physics_update(delta):
	var dir := Input.get_axis("ui_left","ui_right")

	if dir == 0:
		state_machine.change_state("State_Idle")
		return

	var target_speed := (root.stat_data.move_speed)

	root.movement_component.apply_gravity(delta)
	root.movement_component.turn(sign(dir))
	root.movement_component.move(dir, target_speed)

	root.movement_component.apply()

	root.animation_component.play_state("run")

func handle_input(event):
	if event.is_action_pressed("ui_jump"):
		state_machine.change_state("State_Jump")

	if event.is_action_pressed("ui_attack"):
		state_machine.change_state("State_Attack")
