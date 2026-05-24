extends Character
class_name Enemy

var bt_player: BTPlayer
@onready var state_machine = $Comp_FSM
var attack_component : AttackComponent
var enemy_stat : EnemyStat

func _ready():
	super._ready()
	
	enemy_stat = stat_data as EnemyStat
	
	attack_component = get_node_or_null("Comp_Attack")
	assert(attack_component != null, "[Character] attack_component not found.")
	assert(state_machine != null, "Comp_FSM is NULL")
	bt_player = get_node_or_null("BTPlayer")
	assert(bt_player != null, "[Enemy] bt_player not found.")
	assert(bt_player.blackboard != null, "bt_player.blackboard is NULL")
	
	state_machine._initialize(self)
