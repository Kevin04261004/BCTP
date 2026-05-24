# EnemyDeadState.gd
extends EnemyBaseState
class_name EnemyDeadState

@export var fade_duration: float = 0.5

var is_fading := false

func enter(_msg := {}):
	set_current_state(AIState.DEAD)

	enemy.movement_component.stop_all()

	# 충돌 제거
	enemy.set_collision_layer(0)
	enemy.set_collision_mask(0)

	enemy.animation_component.stop_all()
	enemy.animation_component.play("dead")
	# Dead 애니메이션 종료 대기
	enemy.animation_component.animation_finished.connect(
		_on_animation_finished,
		CONNECT_ONE_SHOT
	)
	

func _on_animation_finished(anim_name: String):
	if anim_name != "dead":
		return
	
	start_fade()

func start_fade():
	if is_fading:
		return

	is_fading = true

	var tween := enemy.create_tween()

	tween.tween_property(
		enemy,
		"modulate:a",
		0.0,
		fade_duration
	)

	tween.finished.connect(
		_on_fade_finished
	)

func _on_fade_finished():
	enemy.queue_free()
