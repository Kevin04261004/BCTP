# character.gd
extends CharacterBody2D
class_name MonsterAgent2D

@onready var state_machine = $Comp_FSM
@onready var health = $Comp_Health

func _ready():
	health.connect("died", Callable(self, "_on_character_died"))

func _on_character_died(owner):
	state_machine.change_state("State_Death")
