# IdleState.gd
extends HeroBaseState

func enter(_msg := {}):
	root.movement_component.stop_all()
	root.animation_component.play("idle")

func physics_update(delta):
	root.movement_component.apply_gravity(delta)
	root.movement_component.apply()
	
	if not hero.is_on_floor():
		state_machine.change_state("State_Fall");

func handle_input(event):
	if event.is_action_pressed("ui_dash") and hero.dash_component.can_use():
		state_machine.change_state("State_Dash")
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.change_state("State_Move")
	if Input.is_action_pressed("ui_jump"):
		state_machine.change_state("State_Jump")
	if Input.is_action_pressed("ui_attack"):
		state_machine.change_state("State_Attack")
