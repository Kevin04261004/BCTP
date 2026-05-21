# AnimationComponent.gd
extends Node
class_name AnimationComponent

@export var anim : AnimatedSprite2D

func play_state(state: String):
	if anim.animation != state:
		anim.play(state)
