extends BTCondition
class_name BTIsTargetInAttackRange

var root: OnGroundEnemy
var played := false

func _enter() -> void:
	root = agent as OnGroundEnemy
	assert(root != null, "root is NULL")

func _tick(delta: float) -> Status:
	var target: Hero = blackboard.get_var("target")

	if target == null:
		return FAILURE

	if root.sensor_component.get_attack_target() == null:
		return FAILURE

	return SUCCESS
