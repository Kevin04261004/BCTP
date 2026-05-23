# StateMachine.gd
extends Node
class_name StateMachine

@export var initial_state: String
var current_state: BaseState
var states := {}

func _initialize(owner):
	for child in get_children():
		if child is BaseState:
			child.root = owner
			assert(child.root != null, "child.root is null")
			child.state_machine = self
			assert(child.state_machine != null, "child.state_machine is null")
			states[child.name] = child
			child.setup()
	if initial_state != null:
		change_state(initial_state)

func change_state(state_name: String, msg := {}):
	var key: String = str(state_name)
	if !states.has(key):
		push_error("[StateMachine] State not found: " + key)
		return
		
	var parent_name: String = get_parent().name
	print(parent_name + " -> " + key)

	if current_state != null:
		current_state.exit()
	current_state = states[key]
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
