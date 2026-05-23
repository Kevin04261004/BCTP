extends BTAction
class_name BTAPlayAnimation

@export var animation_string: String

var root: Character
var played := false


func _enter() -> void:
	root = agent as Character
	assert(root != null, "root is NULL")
	
	played = false


func _tick(delta: float) -> int:
	assert(root.movement_component != null, "root.movement_component is NULL")

	if not played:
		root.animation_component.play_state(animation_string)
		played = true

	return SUCCESS
