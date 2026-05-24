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
@onready var movement_component: MovementComponent = $Comp_Movement
@onready var animation_component: AnimationComponent = $Comp_Animation
@onready var attack_component: AttackComponent = $Comp_Attack
@onready var health_component: HealthComponent = $Comp_Health
@export var stat_data: BaseStat

func _ready():
	assert(movement_component != null, "[Character] Comp_Movement not found.")
	assert(animation_component != null, "[Character] Comp_Animation not found.")
	assert(attack_component != null, "[Character] attack_component not found.")
	assert(health_component != null, "[Character] health_component not found.")
	assert(stat_data != null, "[Character] stat_data not found.")
