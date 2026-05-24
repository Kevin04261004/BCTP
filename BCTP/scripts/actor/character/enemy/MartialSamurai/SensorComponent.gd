extends Node
class_name SensorComponent

# =========================
# References
# =========================

var actor: Character

@export var wall_raycast: RayCast2D
@export var ground_raycast: RayCast2D
@export var target_area: Area2D

var targets: Array[Character] = []

# =========================
# Lifecycle
# =========================

func _ready():
	assert(wall_raycast != null, "wall_raycast is NULL")
	assert(ground_raycast != null, "ground_raycast is NULL")
	assert(target_area != null, "target_area is NULL")

	actor = get_parent() as Character

	target_area.body_entered.connect(_on_target_entered)
	target_area.body_exited.connect(_on_target_exited)

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
	_cleanup_targets()

	return not targets.is_empty()

func get_target() -> Character:
	_cleanup_targets()

	if targets.is_empty():
		return null

	var closest_target: Character = null
	var closest_distance := INF

	for target in targets:
		var distance := actor.global_position.distance_squared_to(
			target.global_position
		)

		if distance < closest_distance:
			closest_distance = distance
			closest_target = target

	return closest_target

# =========================
# Internal
# =========================

func _on_target_entered(body: Node2D):
	if not body is Character:
		return

	var character := body as Character

	if character.faction == actor.faction:
		return

	if targets.has(character):
		return

	targets.append(character)

func _on_target_exited(body: Node2D):
	if body is Character:
		targets.erase(body)

func _cleanup_targets():
	targets = targets.filter(
		func(target):
			return is_instance_valid(target)
	)
