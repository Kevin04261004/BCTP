# AnimationComponent.gd
extends Node
class_name AnimationComponent

@export var sprite : AnimatedSprite2D
@export var animation_player : AnimationPlayer

signal animation_finished(anim_name)

func _ready():
	animation_player.animation_finished.connect(_on_animation_finished)

func play_sprite_animation(anim_name:String):
	sprite.play(anim_name)

func play(anim_name:String):
	animation_player.play(anim_name)

func _on_animation_finished(anim_name:String):
	animation_finished.emit(anim_name)
