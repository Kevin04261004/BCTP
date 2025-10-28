# AttackComponent.gd
extends Area2D
class_name AttackComponent

@export var damage: int = 10
@export var attack_animation: String = "attack01"
@onready var animation: Node = get_node("../Comp_Animation")

var is_attacking := false

func PerformAttack():
	if is_attacking:
		return
	is_attacking = true
	animation.play_state(attack_animation)
	check_hit()
	await get_tree().create_timer(0.5).timeout
	is_attacking = false

func check_hit():
	var areas = get_overlapping_areas()
	for area in areas:
		var target = area.get_parent()
		var health = target.get_node_or_null("Comp_Health")
		if health and health.has_method("TakeDamage"):
			health.TakeDamage(get_parent().name, damage)
