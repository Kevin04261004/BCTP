extends Node
class_name MovementComponent

var actor: CharacterBody2D
var gravity: float
var sprite_root: Node2D
var facing_direction: int = 1

func _ready():
	actor = get_parent()
	sprite_root = actor.get_node("SpriteRoot")
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# =========================
# Gravity
# =========================

func apply_gravity(delta: float, multiplier: float = 1.0):
	if not actor.is_on_floor():
		actor.velocity.y += (gravity * multiplier * delta)

# =========================
# Move
# =========================

func move(direction: float, speed: float):
	actor.velocity.x = (direction * speed)

func turn(direction: int = 0):
	if direction == facing_direction:
		return

	if direction == 0:
		facing_direction *= -1

	facing_direction = direction
	sprite_root.scale.x = facing_direction

# =========================
# Jump
# =========================

func jump(force: float):
	actor.velocity.y = -force

# =========================
# Stop
# =========================

func stop_horizontal():
	actor.velocity.x = 0

func stop_vertical():
	actor.velocity.y = 0

func stop_all():
	actor.velocity = Vector2.ZERO

# =========================
# Force
# =========================

func add_force(force: Vector2):
	actor.velocity += force

# =========================
# Apply
# =========================

func apply():
	actor.move_and_slide()
