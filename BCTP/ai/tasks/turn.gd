extends BTAction
class_name BTATurn

var root : Character
var played := false

func _enter() -> void:
	root = agent as Character
	assert(root != null, "root is NULL")
	
	played = false;


func _tick(delta: float) -> int:
	assert(root.movement_component != null, "root.movement_component is NULL")

	if not played:
		root.movement_component.turn()
		played = true


	return SUCCESS
