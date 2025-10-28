# StateMachine.gd
extends Node
class_name StateMachine

@export var initial_state: NodePath
var current_state: BaseState
var states := {}

func _ready():
	for child in get_children():
		if child is BaseState:
			child.player = get_parent()
			child.state_machine = self
			states[child.name] = child
	if initial_state != null:
		change_state(initial_state)

func change_state(state_name: String, msg := {}):
	print("to " + state_name);
	if current_state:
		current_state.exit()
	current_state = states[state_name]
	current_state.enter(msg)

func _input(event):
	if current_state:
		current_state.handle_input(event)

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
