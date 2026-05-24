# JumpState.gd
extends HeroBaseState
# =========================
# Lifecycle
# =========================

func enter(msg := {}):
	root.movement_component.jump(root.stat_data.jump_force)
	root.animation_component.play("jump")


# =========================
# Physics
# =========================

func handle_input(event):
	if event.is_action_pressed("ui_dash") and hero.dash_component.can_use():
		state_machine.change_state("State_Dash")

func physics_update(delta: float):
	root.movement_component.apply_gravity(delta)

	var dir := Input.get_axis("ui_left", "ui_right")
	var move_speed := (root.stat_data.move_speed)
	root.movement_component.move(dir, move_speed)

	if dir != 0:
		root.movement_component.turn(sign(dir))

	root.movement_component.apply()

	if root.velocity.y >= 0:
		state_machine.change_state("State_Fall")
		return

	if root.is_on_floor():
		root.animation_component.play("idle")
		var next_state := ("State_Walk" if dir != 0 else "State_Idle")
		state_machine.change_state(next_state)
