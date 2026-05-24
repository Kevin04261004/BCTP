extends BTCondition
class_name BTTargetInFront

func _tick(_delta: float) -> Status:

	var enemy := agent as Enemy

	if enemy == null:
		return FAILURE

	var target = blackboard.get_var("target")

	if target == null:
		return FAILURE

	if not is_instance_valid(target):
		return FAILURE

	var facing_dir := enemy.movement_component.get_direction()

	# 방향 정보 없으면 실패
	if facing_dir == 0:
		return FAILURE

	var target_dir = sign(target.global_position.x - enemy.global_position.x)

	if target_dir == facing_dir:
		return SUCCESS

	return FAILURE
