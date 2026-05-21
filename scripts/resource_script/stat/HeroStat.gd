# HeroStat.gd
extends BaseStat
class_name HeroStat

# =========================
# Jump
# =========================

@export var jump_force: float = 350.0

# =========================
# Movement
# =========================

@export var run_speed: float = 150.0

# =========================
# Dash
# =========================

@export var dash_power: float = 500.0

@export var dash_duration: float = 0.2

@export var dash_cooldown: float = 1.0



# =========================
# Utility
# =========================

@export var cooldown_reduction: float = 0.0
