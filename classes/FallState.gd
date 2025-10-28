# FallState.gd
extends BaseState

@export var fall_speed_multiplier : float = 1.0   # 하강 시 가속(선택)
@export var air_control_speed : float = 100       # 공중 좌우 이동 속도
@export var min_fall_velocity : float = -500     # 최소 하강 속도(선택)

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter(_msg := {}):
	player.get_node("Comp_Animation").play_state("fall")

func physics_update(delta: float):
	# ----- 좌우 이동 (공중 제어) -----
	var dir = Input.get_axis("ui_left", "ui_right")
	player.velocity.x = dir * air_control_speed
	if dir != 0:
		player.get_node("AnimatedSprite2D").scale.x = sign(dir)
	# ----- 중력 적용 -----
	player.velocity.y += gravity * fall_speed_multiplier * delta
	# (선택) 최대 하강 속도 제한
	player.velocity.y = max(player.velocity.y, min_fall_velocity)
	# TODO: 바닥에 닿을 때 Idle로 전환, Land 애니메이션 실행 하기.
	player.velocity.y = 20;
	# ----- 충돌 및 착지 처리 -----
	player.move_and_slide()
	
	if player.is_on_floor():
		# 착지 애니메이션 → Idle / Walk 로 전환
		player.get_node("Comp_Animation").play_state("land")
		# 이동 중이면 Move, 정지면 Idle
		var target_state = "State_Move" if dir != 0 else "State_Idle"
		state_machine.change_state(target_state)
