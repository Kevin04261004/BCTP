# MoveState.gd
extends BaseState

@export var walk_speed: float = 100
@export var run_speed: float = 200

func enter(_msg := {}):
	character.get_node("Comp_Animation").play_state("walk")

func physics_update(delta):
	var dir = Input.get_axis("ui_left", "ui_right")
	
	if dir == 0:
		state_machine.change_state("State_Idle")
		return;
		
	var is_running = Input.is_action_pressed("ui_run")
	
	var target_speed = walk_speed

	if is_running:
		target_speed = run_speed
		
	
	character.velocity.x = dir * target_speed
	
	if dir != 0:
		character.get_node("AnimatedSprite2D").scale.x = sign(dir)
		
	character.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	character.move_and_slide()

func handle_input(event):
	if Input.is_action_pressed("ui_jump"):
		state_machine.change_state("State_Jump")
	if Input.is_action_pressed("ui_attack"):
		state_machine.change_state("State_Attack")
