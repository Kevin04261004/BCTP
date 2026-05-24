# EnemyStat.gd
extends BaseStat
class_name EnemyStat

# =========================
# AI
# =========================

@export var chase_speed: float = 120.0

# =========================
# Attack
# =========================

@export var attack_cooltime : float = 3

# =========================
# Reward
# =========================

@export var gold_reward: int = 10
@export var jewel_reward: int = 0
