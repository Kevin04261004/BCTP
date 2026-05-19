# ChaseTarget.gd
extends BaseState

@export var chase_speed: float = 80.0

var wall_raycast: RayCast2D
var ground_raycast: RayCast2D
var target_raycast: RayCast2D

var direction: int = 1

# 🎯 추적 대상(플레이어 등)을 저장할 변수
var target_node: Node2D = null

func enter(msg := {}):
	wall_raycast = character.get_node("WallRaycast2D")
	ground_raycast = character.get_node("CheckGroundRaycast2D")
	target_raycast = character.get_node("FindTargetRaycast2D")
	
	# 초기 방향 설정
	if msg.has("direction"):
		direction = msg["direction"]
		
	character.get_node("Comp_Animation").play_state("walk")

	# 💡 진입 시점에 이미 타겟 정보가 들어왔다면 저장 (Patrol에서 넘겨줄 경우 대비)
	if msg.has("target"):
		target_node = msg["target"]


func physics_update(delta: float):
	# 1. 중력 적용
	if not character.is_on_floor():
		character.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta

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
