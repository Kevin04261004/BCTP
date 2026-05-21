# ChaseTarget.gd
extends GroundEnemyBaseState

@export var chase_speed: float = 80.0

func enter(msg := {}):
	animation_component.play_state("walk")


func physics_update(delta: float):
	# 1. 중력 적용
	movement_component.apply_gravity()

	# 2. 타겟 확보 및 유효성 검사 (최적화 포인트)
	if not is_instance_valid(target_node):
		# 타겟이 없거나 삭제되었다면 레이캐스트로 새로 탐색
		if target_raycast.is_colliding():
			var collider = target_raycast.get_collider()
			if collider is Node2D:
				target_node = collider
		else:
			# 레이캐스트에도 걸리지 않으면 순찰 상태로 복귀
			state_machine.change_state("State_Patrol")
			return

	# 3. 상대방 위치 추적 및 방향 계산
	# 타겟의 X 위치와 몬스터의 X 위치를 비교하여 방향 설정
	if target_node.global_position.x > character.global_position.x:
		direction = 1
	else:
		direction = -1
	
	# 캐릭터 외형 및 레이캐스트 방향 업데이트
	_flip_character(direction)

	# 4. 추적 불가능한 상황 예외 처리 (벽에 막히거나 앞에 바닥이 없을 때)
	if character.is_on_floor():
		if wall_raycast.is_colliding() or not ground_raycast.is_colliding():
			# 멈추거나 벽에 막히면 타겟을 잃고 순찰 상태로 복귀
			target_node = null 
			state_machine.change_state("State_Patrol")
			return

	# 5. 빠른 속도로 추적 이동
	character.velocity.x = direction * chase_speed
	character.move_and_slide()


# 캐릭터와 레이캐스트 방향을 반전시키는 헬퍼 함수
func _flip_character(dir: int):
	var sprite = character.get_node_or_null("AnimatedSprite2D")
	if sprite:
		sprite.flip_h = (dir < 0)
		
	wall_raycast.scale.x = dir
	ground_raycast.scale.x = dir
	target_raycast.scale.x = dir
	
	# 2. 벽 및 바닥 감지 레이캐스트 반전
	# scale.x를 1 또는 -1로 만들어 레이캐스트가 뻗어나가는 방향을 통째로 돌립니다.
	if wall_raycast:
		wall_raycast.scale.x = dir
	if ground_raycast:
		ground_raycast.scale.x = dir
		
	# 3. 타겟 감지 레이캐스트도 같이 돌려줍니다.
	if target_raycast:
		target_raycast.scale.x = dir
