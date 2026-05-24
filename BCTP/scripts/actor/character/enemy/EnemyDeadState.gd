# EnemyDeadState.gd
extends EnemyBaseState
class_name EnemyDeadState

@export var fade_duration: float = 1.0

var fade_timer: float = 0.0
var sprite: CanvasItem

func enter(_msg := {}):
	set_current_state(AIState.DEAD)
	enemy.movement_component.stop_all()
	enemy.animation_component.play("dead")

	enemy.set_collision_layer_value(1, false)
	enemy.set_collision_mask_value(1, false)

	sprite = enemy.get_node_or_null("Sprite2D")

func physics_update(delta: float):
	enemy.movement_component.apply_gravity(delta)
	enemy.movement_component.apply()

	if sprite == null:
		return

	fade_timer += delta
	var alpha: float = 1.0 - (fade_timer / fade_duration)
	alpha = clampf(alpha, 0.0, 1.0)
	sprite.modulate.a = alpha
	
	if fade_timer < fade_duration:
		return

	enemy.queue_free()
