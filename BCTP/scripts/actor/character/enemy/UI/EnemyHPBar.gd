extends ProgressBar
class_name EnemyHealthBar

@export var visible_duration := 3.0
var hide_timer := 0.0
var root: Character

func _ready():
	await get_tree().process_frame
	
	root = get_parent() as Character
	root.health_component.hp_changed.connect(_on_hp_changed)
	hide()

func _process(delta):
	if hide_timer > 0.0:
		hide_timer -= delta

	if hide_timer <= 0.0:
		hide()

func _on_hp_changed(current_hp: float, max_hp: float):
	max_value = max_hp
	value = current_hp

	show()
	hide_timer = visible_duration
