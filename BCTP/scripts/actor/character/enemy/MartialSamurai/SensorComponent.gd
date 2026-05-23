extends Node
class_name SensorComponent

# =========================
# References
# =========================

var actor: CharacterBody2D

@export var wall_raycast: RayCast2D
@export var ground_raycast: RayCast2D
@export var target_raycast: RayCast2D
@export var attack_collision: Area2D

# =========================
# Lifecycle
# =========================

func _ready():
	assert(wall_raycast != null, "Wall Raycasr is NULL")
	assert(ground_raycast != null, "ground_raycast is NULL")
	assert(target_raycast != null, "target_raycast is NULL")
	assert(attack_collision != null, "attack_collision is NULL")
	actor = get_parent()

# =========================
# Wall
# =========================

func is_wall_detected() -> bool:
	if wall_raycast == null:
		return false

	return wall_raycast.is_colliding()

# =========================
# Ground
# =========================

func is_ground_detected() -> bool:
	if ground_raycast == null:
		return false

	return ground_raycast.is_colliding()

# =========================
# Target
# =========================

func has_target() -> bool:
	if target_raycast == null:
		return false

	return target_raycast.is_colliding()

func get_target() -> Node2D:
	if not has_target():
		return null

	var collider = target_raycast.get_collider()

	if collider is Hero:
		return collider

	return null

# =========================
# Attack
# =========================

func has_attack_target() -> bool:
	return get_attack_target() != null

func get_attack_target() -> Character:
	if attack_collision == null:
		return null

	var bodies := attack_collision.get_overlapping_bodies()

	for body in bodies:
		if body == actor:
			continue

		if body is Hero:
			return body

	return null
