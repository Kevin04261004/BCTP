extends HeroBaseState

func enter(_msg := {}):
	root.movement_component.stop_vertical()

	root.animation_component.animation_finished.connect(
		_on_animation_finished,
		CONNECT_ONE_SHOT
	)

	root.animation_component.play("attack01")

func _on_animation_finished(anim_name: String):
	if anim_name != "attack01":
		return

	state_machine.change_state("State_Idle")
