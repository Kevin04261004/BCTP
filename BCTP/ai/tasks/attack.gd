extends BTAction
class_name BTAttack

var finished := false
var enemy : Enemy

func _enter():
	finished = false
	enemy = agent as Enemy

	enemy.animation_component.animation_finished.connect(
		_on_animation_finished,
		CONNECT_ONE_SHOT
	)

	blackboard.set_var("is_attacking", true)
	enemy.attack_component.attack()
	enemy.animation_component.play_state("attack01")
	
func _tick(delta: float):
	if finished:
		blackboard.set_var("is_attacking",false)
		return SUCCESS

	return RUNNING
	
func _on_animation_finished(animation_name: String):
	if animation_name != "attack01":
		return

	finished = true
