# BaseStat.gd
extends Resource
class_name BaseStat

# =========================
# Identity
# =========================

@export var display_name: String = "Character"

# =========================
# Health
# =========================

@export var max_hp: int = 100

# =========================
# Movement
# =========================

@export var move_speed: float = 100.0

# =========================
# Combat
# =========================

@export var attack_damage: int = 10

@export var attack_speed: float = 1.0

@export var attack_cooltime: float = 1

# =========================
# Defense
# =========================

@export var defense: int = 0

# =========================
# Critical
# =========================

@export var critical_chance: float = 0.25
@export var critical_damage: float = 1.5
