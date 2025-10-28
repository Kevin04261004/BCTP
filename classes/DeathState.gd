# DeathState.gd
extends BaseState

func enter(_msg := {}):
	player.get_node("Comp_Animation").play_state("death")
	player.velocity = Vector2.ZERO
