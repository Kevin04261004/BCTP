extends Character
class_name Enemy

var sensor_component: SensorComponent
var bt_player: BTPlayer
@onready var state_machine = $Comp_FSM
var enemy_stat : EnemyStat

func _ready():
	super._ready()
	
	sensor_component = get_node_or_null("Comp_Sensor")
	assert(sensor_component != null, "[Character] sensor_component not found.")

	faction = Faction.ENEMY
	enemy_stat = stat_data as EnemyStat

	assert(state_machine != null, "Comp_FSM is NULL")
	bt_player = get_node_or_null("BTPlayer")
	assert(bt_player != null, "[Enemy] bt_player not found.")
	assert(bt_player.blackboard != null, "bt_player.blackboard is NULL")
	
	state_machine._initialize(self)

	health_component.died.connect(_on_died)

func _on_died():
	state_machine.change_state("State_Dead")
