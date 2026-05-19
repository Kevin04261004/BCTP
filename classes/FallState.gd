# FallState.gd
extends BaseState

@export var fall_speed_multiplier : float = 1.0   # 하강 시 가속(선택)
@export var air_control_walk_speed : float = 100   # 점프 상승 중 좌우 이동 속도
@export var air_control_run_speed : float = 200 
@export var min_fall_velocity : float = -500  # 최소 하강 속도(선택)

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter(_msg := {}):
	character.get_node("Comp_Animation").play_state("fall")

func physics_update(delta: float):
	# ----- 좌우 이동 (공중 제어) -----
	var dir = Input.get_axis("ui_left", "ui_right")
	
	var target_speed = air_control_walk_speed

	if Input.is_action_pressed("ui_run"):
		target_speed = air_control_run_speed
		
	
	character.velocity.x = dir * target_speed
	if dir != 0:
		character.get_node("AnimatedSprite2D").scale.x = sign(dir)
	# ----- 중력 적용 -----
	character.velocity.y += gravity * fall_speed_multiplier * delta
	# (선택) 최대 하강 속도 제한
	character.velocity.y = max(character.velocity.y, min_fall_velocity)
	# TODO: 바닥에 닿을 때 Idle로 전환, Land 애니메이션 실행 하기.
	# ----- 충돌 및 착지 처리 -----
	character.move_and_slide()
	
	if character.is_on_floor():
		# 착지 애니메이션 → Idle / Walk 로 전환
		character.get_node("Comp_Animation").play_state("land")
		# 이동 중이면 Move, 정지면 Idle
		var target_state = "State_Move" if dir != 0 else "State_Idle"
		state_machine.change_state(target_state)
