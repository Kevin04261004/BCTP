# Hero.gd
extends Character
class_name Hero

@onready var state_machine = $Comp_FSM


func _ready():
	super._ready()
	
	assert(state_machine != null, "Comp_FSM is NULL")
	
	state_machine._initialize(self)
