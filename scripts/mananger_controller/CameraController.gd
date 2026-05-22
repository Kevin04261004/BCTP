# CameraController.gd
extends Node
class_name CameraController

@export var camera: Camera2D

var target: Node2D

func follow(node: Node2D):
	assert(node != null, "[CameraController] target is null.")
	target = node

func _process(delta):
	if target == null:
		return

	camera.global_position = target.global_position
