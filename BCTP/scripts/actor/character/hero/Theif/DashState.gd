extends HeroBaseState
class_name HeroDashState

var timer: float

func enter(_msg := {}):
	hero.dash_component.set_cooltime()
	timer = hero.hero_stat.dash_duration
	root.animation_component.play_state("dash")

func physics_update(delta: float):
	timer -= delta

	var direction := hero.movement_component.get_direction()
	var dash_speed = hero.hero_stat.dash_power;
	
	root.movement_component.stop_vertical()
	root.movement_component.dash(direction, dash_speed)
	root.movement_component.apply()

	if timer > 0.0:
		return

	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.change_state("State_Move")
	else:
		state_machine.change_state("State_Idle")
