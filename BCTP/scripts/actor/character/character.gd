# Character.gd
extends CharacterBody2D
class_name Character

# =========================
# Components
# =========================

enum Faction
{
	PLAYER,
	ENEMY
}

@export var faction : Faction
var movement_component: MovementComponent
var animation_component: AnimationComponent
var attack_component : AttackComponent
var health_component : HealthComponent
@export var stat_data: BaseStat

func _ready():
	movement_component = get_node_or_null("Comp_Movement")
	assert(movement_component != null, "[Character] Comp_Movement not found.")
	animation_component = get_node_or_null("Comp_Animation")
	assert(animation_component != null, "[Character] Comp_Animation not found.")
	attack_component = get_node_or_null("Comp_Attack")
	assert(attack_component != null, "[Character] attack_component not found.")
	health_component = get_node_or_null("Comp_Health")
	assert(health_component != null, "[Character] health_component not found.")
	assert(stat_data != null, "[Character] stat_data not found.")
