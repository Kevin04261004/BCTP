extends Node
class_name AttackComponent

var cooldown_timer: float = 0.0
var enemy : Enemy

func _ready() -> void:
	enemy = get_parent() as Enemy
	
func _process(delta):
	if cooldown_timer > 0.0:
		cooldown_timer -= delta

func can_attack() -> bool:
	return cooldown_timer <= 0.0

func attack():
	cooldown_timer = enemy.stat_data.attack_cooltime


func perform_attack():
	print("Perform ATTACK")
	pass
