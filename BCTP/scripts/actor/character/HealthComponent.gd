extends Node
class_name HealthComponent

signal hp_changed(current_hp: float, max_hp: float)
signal damaged(amount: float)
signal died

var root : Character
var current_hp : float

func _ready():
	root = get_parent() as Character
	assert(root != null)
	current_hp = root.stat_data.max_hp

func take_damage(amount: float):
	if is_dead():
		return
		
	# TODO: 방어력 공식 적용
	var final_damage = amount #max(1.0, amount - root.stat_data.defense)
	current_hp -= final_damage
	damaged.emit(final_damage)
	hp_changed.emit(current_hp, root.stat_data.max_hp)

	print(root.name, " Damage : ", final_damage)

	if current_hp <= 0.0:
		die()

func heal(amount: float):
	if is_dead():
		return

	current_hp = min(current_hp + amount, root.stat_data.max_hp)
	hp_changed.emit(current_hp, root.stat_data.max_hp)

func die():
	current_hp = 0.0
	died.emit()

func is_dead() -> bool:
	return current_hp <= 0.0

func get_hp_percent() -> float:
	return current_hp / root.stat_data.max_hp
