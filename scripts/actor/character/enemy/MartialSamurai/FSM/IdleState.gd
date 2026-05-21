# IdleState.gd
extends GroundEnemyBaseState

var idle_timer: float = 0.0
@export var idle_duration: float = 2.0  # Idle 상태 유지 시간 (2초)
var target_raycast: RayCast2D

func enter(_msg := {}):
	character.velocity = Vector2.ZERO
	character.get_node("Comp_Animation").play_state("idle")
	
	target_raycast = character.get_node("FindTargetRaycast2D")
	
	# 상태에 진입할 때 타이머 초기화
	idle_timer = 0.0

func physics_update(delta):
	# 중력 적용
	character.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	character.move_and_slide()
	
		# 4. 적 감지 시 즉시 추적 상태로 전환 (타이머 무시)
	if target_raycast.is_colliding():
		state_machine.change_state("State_ChaseTarget")
		return # 상태가 바뀌었으므로 아래 타이머 로직은 실행하지 않음
	
	
	# 시간 누적
	idle_timer += delta
	
	# 2초가 지나면 Patrol 상태로 전환
	if idle_timer >= idle_duration:
		state_machine.change_state("State_Patrol")
