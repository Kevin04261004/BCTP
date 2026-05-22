# Singleton.gd
extends Node
class_name Singleton

static var instance: Singleton

func _ready():
	if instance != null:

		push_error("%s already exists." % name)

		queue_free()
		return

	instance = self
