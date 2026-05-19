# DeathState.gd
extends BaseState

func enter(_msg := {}):
	character.get_node("Comp_Animation").play_state("death")
	character.velocity = Vector2.ZERO
