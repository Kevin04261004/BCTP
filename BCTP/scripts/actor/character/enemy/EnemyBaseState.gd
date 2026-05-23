# EnemyBaseState.gd
extends BaseState
class_name EnemyBaseState

# 현재 GODOT Limbo AI가 BlackBoardPlan을 상속받아 리소스를 만들어 공유하는 것이 불가
# 어쩔 수 없이 몬스터마다 각자 빌트인 BBPlan을 사용해야함.
# 추후 Limbo AI업데이트가 되면 공통 BBPlan제작을 필요로 함.

# 오류 내용:
# WARNING: bt\bt_player.cpp:87 - BTPlayer:
# Using external resource for derived blackboard plan is not supported.
# Converted to built-in resource.

enum AIState
{
	NORMAL = 0,	# 0
	COMBAT,		# 1
	STUN,		# 2
	DEAD		# 3
}
var enemy: Enemy

const BB_TARGET := "target"
const BB_CURRENT_STATE := "current_state"
const BB_IS_ATTACKING := "is_attacking"
const BB_MAX_PHASE := "max_phase"
const BB_CURRENT_PHASE := "current_phase"

func setup():
	super.setup()
	enemy = root as Enemy
	assert(enemy != null, "[EnemyBaseState] root is not Enemy.")
	assert(enemy.bt_player != null, "[EnemyBaseState] enemy.bt_player is not Enemy.")
	assert(enemy.bt_player.blackboard != null, "[EnemyBaseState] enemy.bt_player.blackboard is not Enemy.")

func set_current_state(state: AIState):
	enemy.bt_player.blackboard.set_var(BB_CURRENT_STATE, state)
	
func get_current_state() -> AIState:
	return enemy.bt_player.blackboard.get_var(BB_CURRENT_STATE);
	
func set_target(target: Character):
	enemy.bt_player.blackboard.set_var(BB_TARGET, target)

func get_target() -> Character:
	return enemy.bt_player.blackboard.get_var(BB_TARGET)

func set_current_phase(phase: int):
	enemy.bt_player.blackboard.set_var(BB_CURRENT_STATE, phase)

func get_current_phase() -> int:
	return enemy.bt_player.blackboard.get_var(BB_CURRENT_STATE)

func get_max_phase() -> int:
	return enemy.bt_player.blackboard.get_var(BB_MAX_PHASE)

func next_phase():
	var current_phase: int = get_current_phase()
	var max_phase: int = get_max_phase()

	if current_phase >= max_phase:
		return

	set_current_phase(current_phase + 1)
