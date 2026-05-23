# IdleState.gd
extends HeroBaseState

func enter(_msg := {}):
	root.movement_component.stop_all()
	root.animation_component.play_state("idle")

func physics_update(delta):
	root.movement_component.apply_gravity(delta)
	root.movement_component.apply()

func handle_input(event):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_run") and Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_run") and Input.is_action_pressed("ui_right"):
		state_machine.change_state("State_Move")
	if Input.is_action_pressed("ui_jump"):
		state_machine.change_state("State_Jump")
	if Input.is_action_pressed("ui_attack"):
		state_machine.change_state("State_Attack")
