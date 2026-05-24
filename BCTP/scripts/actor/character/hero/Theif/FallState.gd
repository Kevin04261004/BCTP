# FallState.gd
extends HeroBaseState

func enter(_msg := {}):
	root.animation_component.play_state("fall")

func handle_input(event):
	if event.is_action_pressed("ui_dash"):
		state_machine.change_state("State_Dash")

func physics_update(delta: float):
	var dir := Input.get_axis("ui_left","ui_right")
	
	var target_speed := (root.stat_data.move_speed)
	root.movement_component.apply_gravity(delta)
	root.movement_component.move(dir, target_speed)

	if dir != 0:
		root.movement_component.turn(sign(dir))

	root.movement_component.apply()

	if root.is_on_floor():
		root.animation_component.play_state("land")
		var next_state := ("State_Move" if dir != 0 else "State_Idle")
		state_machine.change_state(next_state)
