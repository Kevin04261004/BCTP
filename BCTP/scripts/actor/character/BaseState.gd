# BaseState.gd
extends Node
class_name BaseState

# =========================
# References
# =========================

var root: Character
var state_machine: Node

# =========================
# Lifecycle
# =========================

func setup(): pass
func enter(_msg := {}): pass
func exit(): pass
func update(_delta): pass
func physics_update(_delta): pass
func handle_input(_event): pass
