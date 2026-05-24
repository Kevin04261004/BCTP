extends Character
class_name Enemy

@onready var sensor_component: SensorComponent = $Comp_Sensor
@onready var bt_player: BTPlayer = $BTPlayer
@onready var state_machine = $Comp_FSM
var enemy_stat : EnemyStat

func _ready():
	super._ready()
	
	assert(sensor_component != null, "[Character] sensor_component not found.")

	faction = Faction.ENEMY
	enemy_stat = stat_data as EnemyStat

	assert(state_machine != null, "Comp_FSM is NULL")
	assert(bt_player != null, "[Enemy] bt_player not found.")
	assert(bt_player.blackboard != null, "bt_player.blackboard is NULL")
	
	state_machine._initialize(self)

	health_component.died.connect(_on_died)

func _on_died():
	state_machine.change_state("State_Dead")
