extends Enemy
class_name OnGroundEnemy

var sensor_component: SensorComponent

func _ready():
	super._ready()
	sensor_component = get_node_or_null("Comp_Sensor")
	assert(sensor_component != null, "[Character] sensor_component not found.")
