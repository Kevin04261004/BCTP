extends Node
class_name SensorComponent

# =========================
# References
# =========================

var actor: CharacterBody2D

@export var wall_raycast: RayCast2D
@export var ground_raycast: RayCast2D
@export var target_raycast: RayCast2D

# =========================
# Lifecycle
# =========================

func _ready():
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

	if collider is Node2D:
		return collider

	return null
