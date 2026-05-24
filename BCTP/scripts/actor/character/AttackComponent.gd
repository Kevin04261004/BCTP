extends Node
class_name AttackComponent

var cooldown_timer : float = 0.0
var root : Character

@export var attack_collision : Area2D

func _ready():
	root = get_parent() as Character

	assert(root != null)
	assert(attack_collision != null)

func _process(delta):
	if cooldown_timer > 0.0:
		cooldown_timer -= delta

func can_attack() -> bool:
	return cooldown_timer <= 0.0

func attack():
	if not can_attack():
		return

	cooldown_timer = root.stat_data.attack_cooltime

func hit():
	var targets := get_attack_targets()

	for target in targets:
		target.health_component.take_damage(root.stat_data.attack_damage)

func has_attack_target() -> bool:
	return not get_attack_targets().is_empty()

func get_attack_target() -> Character:
	var targets := get_attack_targets()

	if targets.is_empty():
		return null

	return targets[0]

func get_attack_targets() -> Array[Character]:
	var result : Array[Character] = []

	if attack_collision == null:
		return result

	var bodies := attack_collision.get_overlapping_bodies()

	for body in bodies:

		if body == root:
			continue

		if not body is Character:
			continue

		var character := body as Character

		if character.faction == root.faction:
			continue

		result.append(character)

	return result
