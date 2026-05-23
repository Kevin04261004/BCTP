extends BTAction
class_name BTAMoveForward

var root : Character

func _enter() -> void:
	root = agent as Character
	assert(root != null, "root is NULL")


func _tick(delta: float) -> int:
	assert(root.movement_component != null, "root.movement_component is NULL")
	assert(root.stat_data != null, "root.stat_data is NULL")

	var dir = root.movement_component.get_direction()
	var speed = root.stat_data.move_speed
	
	root.movement_component.apply_gravity(delta)
	root.movement_component.move(dir, speed)
	root.movement_component.apply()

	return SUCCESS
