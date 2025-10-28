# HealthComponent.gd
extends Node
class_name HealthComponent

signal died(owner)

@export var max_health: int = 100
var current_health: int

func _ready():
	current_health = max_health

func TakeDamage(attacker: String, amount: int):
	current_health -= amount
	print("%s가 %d 데미지를 받음 (남은 체력: %d)" % [get_parent().name, amount, current_health])
	if current_health <= 0:
		current_health = 0
		emit_signal("died", get_parent())
