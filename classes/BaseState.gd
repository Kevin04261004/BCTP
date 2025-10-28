# BaseState.gd
extends Node
class_name BaseState

var player: CharacterBody2D
var state_machine: Node

func enter(_msg := {}): pass
func exit(): pass
func handle_input(_event): pass
func update(_delta): pass
func physics_update(_delta): pass
