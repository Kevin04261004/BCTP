# JumpState.gd
extends BaseState

@export var jump_force : float = 400
@export var air_control_speed : float = 100   # 점프 상승 중 좌우 이동 속도
@export var coyote_time : float = 0.1        # 코요테 타임 (선택)

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var _coyote_timer : float = 0.0

func enter(_msg := {}):
	# 점프 입력이 들어온 순간
	player.velocity.y = -jump_force
	player.get_node("Comp_Animation").play_state("jump")
	
	# 코요테 타이머 초기화
	_coyote_timer = coyote_time if _msg.get("coyote", false) else 0.0

func physics_update(delta: float):
	# ----- 코요테 타임 처리 (절벽에서 살짝 떨어진 뒤에도 점프 가능) -----
	if _coyote_timer > 0:
		_coyote_timer -= delta
		if player.is_on_floor():
			_coyote_timer = 0.0   # 바닥에 닿으면 즉시 종료
	
	# ----- 좌우 이동 (공중 제어) -----
	var dir = Input.get_axis("ui_left", "ui_right")
	player.velocity.x = dir * air_control_speed
	if dir != 0:
		player.get_node("AnimatedSprite2D").scale.x = sign(dir)
	# ----- 중력 -----
	player.velocity.y += gravity * delta
	
	player.move_and_slide()
	
	# ----- 정점 도달 → FallState 로 전환 -----
	if player.velocity.y >= 0:   # 상승 끝, 하강 시작
		state_machine.change_state("State_Fall")
	
	# ----- 착지 (코요테 타임 중에도) -----
	if player.is_on_floor():
		player.get_node("Comp_Animation").play_state("land")
		var target_state = "State_Walk" if dir != 0 else "State_Idle"
		state_machine.change_state(target_state)
