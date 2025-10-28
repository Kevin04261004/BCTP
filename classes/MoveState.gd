# MoveState.gd
extends BaseState

@export var speed: float = 100

func enter(_msg := {}):
	player.get_node("Comp_Animation").play_state("walk")

func physics_update(delta):
	var dir = Input.get_axis("ui_left", "ui_right")
	if dir == 0:
		state_machine.change_state("State_Idle")
		return;
	player.velocity.x = dir * speed
	if dir != 0:
		player.get_node("AnimatedSprite2D").scale.x = sign(dir)
	player.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	player.move_and_slide()

func handle_input(event):
	if Input.is_action_pressed("ui_jump"):
		state_machine.change_state("State_Jump")
	if Input.is_action_pressed("ui_attack"):
		state_machine.change_state("State_Attack")
