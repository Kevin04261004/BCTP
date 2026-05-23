# Character.gd
extends CharacterBody2D
class_name Character

# =========================
# Components
# =========================

var movement_component: MovementComponent
var animation_component: AnimationComponent
@export var stat_data: BaseStat

func _ready():
	movement_component = get_node_or_null("Comp_Movement")
	assert(movement_component != null, "[Character] Comp_Movement not found.")
	animation_component = get_node_or_null("Comp_Animation")
	assert(animation_component != null, "[Character] Comp_Animation not found.")
	assert(stat_data != null, "[Character] stat_data not found.")
