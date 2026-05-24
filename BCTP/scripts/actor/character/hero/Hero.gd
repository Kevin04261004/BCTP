# Hero.gd
extends Character
class_name Hero

@onready var state_machine = $Comp_FSM
var hero_stat : HeroStat
var dash_component : DashComponent

func _ready():
	super._ready()
	
	dash_component = get_node_or_null("Comp_Dash")
	assert(dash_component != null, "[Character] Dash_component not found.")
	assert(state_machine != null, "Comp_FSM is NULL")
	
	hero_stat = stat_data as HeroStat
	state_machine._initialize(self)
