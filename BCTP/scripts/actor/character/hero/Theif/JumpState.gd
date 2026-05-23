# JumpState.gd
extends HeroBaseState

# =========================
# Settings
# =========================

@export var coyote_time: float = 0.1

# =========================
# Internal
# =========================

var coyote_timer: float = 0.0

# =========================
# Lifecycle
# =========================

func enter(msg := {}):
	root.movement_component.jump(root.stat_data.jump_force)
	root.animation_component.play_state("jump")

	coyote_timer = (coyote_time if msg.get("coyote", false) else 0.0)

# =========================
# Physics
# =========================

func physics_update(delta: float):
	root.movement_component.apply_gravity(delta)

	var dir := Input.get_axis("ui_left", "ui_right")
	var move_speed := (root.stat_data.move_speed)
	root.movement_component.move(dir, move_speed)

	if dir != 0:
		root.movement_component.turn(sign(dir))

	root.movement_component.apply()


	if coyote_timer > 0:
		coyote_timer -= delta
		if root.is_on_floor():
			coyote_timer = 0.0

	if root.velocity.y >= 0:
		state_machine.change_state("State_Fall")
		return

	if root.is_on_floor():
		root.animation_component.play_state("State_Idle")
		var next_state := ("State_Walk" if dir != 0 else "State_Idle")
		state_machine.change_state(next_state)
