extends BTCondition
class_name BTCMoveBlockCheck

var root: Enemy


func _enter() -> void:
	root = agent as Enemy
	assert(root != null, "Root is NULL");


func _tick(delta: float) -> int:
	if not can_move_forward():
		return FAILURE

	return SUCCESS


func can_move_forward() -> bool:
	assert(root.sensor_component != null, "root.sensor_component is null")

	# 바닥 없으면 이동 불가
	if not root.sensor_component.is_ground_detected():
		return false

	# 벽 있으면 이동 불가
	if root.sensor_component.is_wall_detected():
		return false

	return true
	
	
	
	
	
	
	
