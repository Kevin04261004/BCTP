# MoveState.gd
extends HeroBaseState

func physics_update(delta):
	var dir := Input.get_axis("ui_left","ui_right")

	if dir == 0:
		state_machine.change_state("State_Idle")
		return

	var target_speed := (root.stat_data.move_speed)

	if Input.is_action_pressed("ui_run"):
		target_speed = (root.stat_data.run_speed)

	root.movement_component.apply_gravity(delta)
	root.movement_component.turn(sign(dir))
	root.movement_component.move(dir, target_speed)

	root.movement_component.apply()

	# TODO: 버그 수정
	var speed_ratio = 1 #(abs(root.velocity.x) / root.stat_data.move_speed)

	if speed_ratio < 0.6:
		root.animation_component.play_state("walk")
	else:
		root.animation_component.play_state("run")

	# root.animation_component.set_speed(max(speed_ratio, 0.5) * 1.5)


func handle_input(event):
	if event.is_action_pressed("ui_jump"):
		state_machine.change_state("State_Jump")

	if event.is_action_pressed("ui_attack"):
		state_machine.change_state("State_Attack")
