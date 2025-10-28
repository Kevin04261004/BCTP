# AttackState.gd
extends BaseState

# TODO: timer가 아닌 애니메이션 프레임으로 변경.
# 만약 가능하다면 5초 안에 애니메이션이 실행이 되도록 변경.
@export var attack_duration: float = 5
var timer := 0.0

func enter(_msg := {}):
	player.velocity = Vector2.ZERO
	player.get_node("Comp_Animation").play_state("attack01")
	player.get_node("Comp_Attack").PerformAttack()
	timer = 0.0

func physics_update(delta):
	timer += delta
	if timer >= attack_duration:
		state_machine.change_state("State_Idle")
