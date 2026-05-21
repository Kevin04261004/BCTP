# GroundEnemyBaseState.gd
extends EnemyBaseState
class_name GroundEnemyBaseState

# =========================
# Components
# =========================

var sensor_component

# =========================
# Lifecycle
# =========================

func setup():
	super()
	sensor_component = root.get_node_or_null("Comp_Sensor")

# =========================
# Ground Check
# =========================

func is_wall_detected() -> bool:
	return sensor_component.is_wall_detected()

func is_ground_detected() -> bool:
	return sensor_component.is_ground_detected()

# =========================
# Target
# =========================

func has_target() -> bool:
	return sensor_component.has_target()

func get_target() -> Node2D:
	return sensor_component.get_target()
