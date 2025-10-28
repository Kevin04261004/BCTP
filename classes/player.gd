# Player.gd
extends CharacterBody2D
class_name Player

@onready var state_machine = $Comp_FSM
@onready var health = $Comp_Health

func _ready():
	health.connect("died", Callable(self, "_on_player_died"))

func _on_player_died(owner):
	state_machine.change_state("State_Death")
