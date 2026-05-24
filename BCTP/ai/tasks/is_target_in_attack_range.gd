extends BTCondition
class_name BTCIsTargetInAttackRange

var root: Enemy
var played := false

func _enter() -> void:
	root = agent as Enemy
	assert(root != null, "root is NULL")

func _tick(delta: float) -> Status:
	var target: Hero = blackboard.get_var("target")

	if target == null:
		return FAILURE

	if root.attack_component.get_attack_target() == null:
		return FAILURE

	return SUCCESS
