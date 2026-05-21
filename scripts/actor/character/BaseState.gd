# BaseState.gd
extends Node
class_name BaseState

# =========================
# References
# =========================

var root: CharacterBody2D
var state_machine: Node

# =========================
# Components
# =========================

var movement_component
var animation_component

# =========================
# Lifecycle
# =========================

func setup():
	movement_component = root.get_node_or_null("Comp_Movement")
	animation_component = root.get_node_or_null("Comp_Animation")

func enter(_msg := {}):
	pass

func exit():
	pass

func update(_delta):
	pass

func physics_update(_delta):
	pass

func handle_input(_event):
	pass
