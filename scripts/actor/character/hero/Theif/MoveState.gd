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
	
	var target_speed = walk_speed

	if Input.is_action_pressed("ui_run"):
		target_speed = run_speed
	
	# 실제 속도 비율
	var speed_ratio = abs(character.velocity.x) / run_speed

	# 애니메이션 전환
	if speed_ratio < 0.6:
		character.get_node("Comp_Animation").play_state("walk")
	else:
		character.get_node("Comp_Animation").play_state("run")

	# 애니메이션 재생 속도
	character.get_node("AnimatedSprite2D").speed_scale = max(speed_ratio, 0.5) * 1.5
		
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
