# IdleState.gd
extends BaseState

func enter(_msg := {}):
	player.velocity = Vector2.ZERO
	player.get_node("Comp_Animation").play_state("idle")

func physics_update(delta):
	player.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	player.move_and_slide()

func handle_input(event):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.change_state("State_Move")
	if Input.is_action_pressed("ui_jump"):
		state_machine.change_state("State_Jump")
	if Input.is_action_pressed("ui_attack"):
		state_machine.change_state("State_Attack")
