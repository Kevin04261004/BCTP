# DashComponent.gd
extends Node
class_name DashComponent

var cooldown_timer: float = 0.0
var hero : Hero

func _ready() -> void:
	hero = get_parent() as Hero

func _process(delta):
	if cooldown_timer > 0.0:
		cooldown_timer -= delta

func can_use() -> bool:
	return cooldown_timer <= 0.0

func set_cooltime():
	cooldown_timer = hero.hero_stat.dash_cooldown
