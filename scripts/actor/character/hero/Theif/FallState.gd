# FallState.gd
extends HeroBaseState

# =========================
# Settings
# =========================

@export var fall_speed_multiplier: float = 1.0
@export var min_fall_velocity: float = 500.0

# =========================
# Lifecycle
# =========================

func enter(_msg := {}):

	root.animation_component.play_state(
		"fall"
	)

# =========================
# Physics
# =========================

func physics_update(delta: float):

	# -------------------------
	# Input
	# -------------------------

	var dir := Input.get_axis(
		"ui_left",
		"ui_right"
	)

	# -------------------------
	# Speed
	# -------------------------

	var target_speed := (
		root.stat_data.move_speed
	)

	if Input.is_action_pressed(
		"ui_run"
	):

		target_speed = (
			root.stat_data.run_speed
		)

	# -------------------------
	# Gravity
	# -------------------------

	root.movement_component.apply_gravity(
		delta,
		fall_speed_multiplier
	)

	# -------------------------
	# Max Fall Speed
	# -------------------------

	root.velocity.y = min(
		root.velocity.y,
		min_fall_velocity
	)

	# -------------------------
	# Air Control
	# -------------------------

	root.movement_component.move(
		dir,
		target_speed
	)

	# -------------------------
	# Turn
	# -------------------------

	if dir != 0:

		root.movement_component.turn(
			sign(dir)
		)

	# -------------------------
	# Apply
	# -------------------------

	root.movement_component.apply()

	# -------------------------
	# Landing
	# -------------------------

	if root.is_on_floor():

		root.animation_component.play_state(
			"land"
		)

		var next_state := (
			"State_Move"
			if dir != 0
			else "State_Idle"
		)

		state_machine.change_state(
			next_state
		)
