extends HeroBaseState

var combo_step := 1
var combo_requested := false # 다음 공격 예약 여부

func enter(_msg := {}):
	combo_step = 1
	combo_requested = false
	root.movement_component.stop_vertical()
	
	# 연결이 이미 되어있을 경우를 대비해 처리
	if not root.animation_component.animation_finished.is_connected(_on_animation_finished):
		root.animation_component.animation_finished.connect(_on_animation_finished)
		
	root.animation_component.play("attack01")

func exit():
	if root.animation_component.animation_finished.is_connected(_on_animation_finished):
		root.animation_component.animation_finished.disconnect(_on_animation_finished)

func play_attack():
	root.animation_component.play("attack0" + str(combo_step))

func handle_input(event: InputEvent):
	if event.is_action_pressed("ui_jump"):
		state_machine.change_state("State_Jump")
	if event.is_action_pressed("ui_dash"):
		state_machine.change_state("State_Dash")
	
	if event.is_action_pressed("ui_attack"):
		if combo_step < 3:
			combo_requested = true

func _on_animation_finished(anim_name: String):
	# 현재 재생 중인 공격이 끝났을 때
	if anim_name.begins_with("attack"):
		# 예약된 공격이 있다면 다음 단계로 진행
		if combo_requested and combo_step < 3:
			combo_step += 1
			combo_requested = false # 예약 초기화
			play_attack()
		else:
			# 예약이 없다면 상태 종료 (Idle/Move/Fall)
			var dir := Input.get_axis("ui_left", "ui_right")
			if root.is_on_floor():
				var next_state := ("State_Move" if dir != 0 else "State_Idle")
				state_machine.change_state(next_state)
			else:
				state_machine.change_state("State_Fall")
