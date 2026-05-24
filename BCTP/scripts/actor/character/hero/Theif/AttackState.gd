extends HeroBaseState

func enter(_msg := {}):
	root.movement_component.stop_vertical()

	root.animation_component.animation_finished.connect(
		_on_animation_finished,
		CONNECT_ONE_SHOT
	)

	root.animation_component.play("attack01")

func handle_input(event: InputEvent):
	if event.is_action_pressed("ui_jump"):
		state_machine.change_state("State_Jump")
	
	if event.is_action_pressed("ui_dash"):
		state_machine.change_state("State_Dash")

func _on_animation_finished(anim_name: String):
	if anim_name != "attack01":
		return
		
	var dir := Input.get_axis("ui_left","ui_right")
	if root.is_on_floor():
		var next_state := ("State_Move" if dir != 0 else "State_Idle")
		state_machine.change_state(next_state)
	else:
		state_machine.change_state("State_Fall")
		
		
		
