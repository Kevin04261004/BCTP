# AnimationComponent.gd
extends Node
class_name AnimationComponent

@export var sprite : AnimatedSprite2D
signal animation_finished(animation_name)

func _ready():
	sprite.animation_finished.connect(_on_animated_sprite_2d_animation_finished)

func play_state(state: String):
	if sprite.animation != state:
		sprite.play(state)

func _on_animated_sprite_2d_animation_finished():
	animation_finished.emit(sprite.animation)
