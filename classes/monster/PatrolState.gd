# PatrolState.gd
extends BaseState

@export var normal_speed: float = 50.0
@export var patrol_duration: float = 5.0  # Patrol 상태 유지 시간 (5초)

var wall_raycast: RayCast2D
var ground_raycast: RayCast2D
var target_raycast: RayCast2D

var direction: int = 1
var patrol_timer: float = 0.0

func enter(_msg := {}):
	wall_raycast = character.get_node("WallRaycast2D")
	ground_raycast = character.get_node("CheckGroundRaycast2D")
	target_raycast = character.get_node("FindTargetRaycast2D")
	
	# 애니메이션 재생 (Comp_Animation 방식 적용)
	character.get_node("Comp_Animation").play_state("walk")
	
	# 상태 진입 시 타이머 초기화
	patrol_timer = 0.0
	

func physics_update(delta: float):
	# 1. 중력 적용
	if not character.is_on_floor():
		character.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	else:
		character.velocity.y = 0

	# 2. 벽 및 낭떠러지 감지 후 방향 전환
	#if character.is_on_floor():
		
	if wall_raycast.is_colliding() or not ground_raycast.is_colliding():
		direction *= -1
		_flip_character(direction)
		
	# 3. 이동 처리
	character.velocity.x = direction * normal_speed
	character.move_and_slide()

	# 4. 적 감지 시 즉시 추적 상태로 전환 (타이머 무시)
	if target_raycast.is_colliding():
		state_machine.change_state("State_ChaseTarget")
		return # 상태가 바뀌었으므로 아래 타이머 로직은 실행하지 않음

	# 5. 시간 누적 및 Idle 상태 전환
	patrol_timer += delta
	if patrol_timer >= patrol_duration:
		state_machine.change_state("State_Idle") # 혹은 에디터에 설정된 Idle 상태 노드 이름 입력

func _flip_character(dir: int):
	# 노드 반전 로직 (스프라이트 flip_h 대신 Comp_Animation이나 루트 노드의 scale을 바꾼다면 그에 맞게 수정 가능)
	var sprite = character.get_node_or_null("AnimatedSprite2D")
	if sprite:
		sprite.flip_h = (dir < 0)
		
	wall_raycast.scale.x = dir
	ground_raycast.scale.x = dir
	target_raycast.scale.x = dir
	
	# scale.x를 1 또는 -1로 만들어 레이캐스트가 뻗어나가는 방향을 통째로 돌립니다.
	if wall_raycast:
		wall_raycast.scale.x = dir
	if ground_raycast:
		ground_raycast.scale.x = dir
		
	# 3. 타겟 감지 레이캐스트도 같이 돌려줍니다.
	if target_raycast:
		target_raycast.scale.x = dir
