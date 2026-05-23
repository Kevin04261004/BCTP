# Hero.gd
extends Character
class_name Hero

@onready var state_machine = $Comp_FSM


func _ready():
	super._ready()
	state_machine._initialize(self)
