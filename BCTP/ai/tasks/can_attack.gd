extends BTCondition
class_name BTCanAttack

var enemy : Enemy

func _tick(delta: float):
	enemy = agent as Enemy

	assert(enemy != null, "Enemy is NULL")
	assert(enemy.attack_component != null, "Enemy.attack_component is NULL")

	if enemy.attack_component.can_attack():
		return SUCCESS

	return FAILURE
