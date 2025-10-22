extends Node

signal DiedSignal;

@export var MaxHp : float = 100;
@export var CurHp : float = 0;

func _ready() -> void:
	CurHp = MaxHp;

func TakeDamage(from: String, amount: float) -> void:
	var parentName = get_parent().name;
	
	CurHp -= amount;
	if CurHp <= 0:
		Died();
	print(parentName + " get " + str(amount) + " damage from " + from + "\ncurHp: " + str(CurHp));
	
		
func Died() -> void:
	emit_signal("DiedSignal");
	
