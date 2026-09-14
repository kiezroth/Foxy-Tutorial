class_name StateMachine extends Node

var current_state: State
var previous_state : State
var state_list: Array[State]

var entity

func _ready() -> void:
	entity = get_parent()
	process_mode = Node.PROCESS_MODE_DISABLED
	

func _process(_delta: float) -> void:
	ChangeState(current_state.Process(_delta))

func _physics_process(_delta: float) -> void:
	ChangeState(current_state.Physics(_delta))

func _unhandled_input(_event: InputEvent) -> void:
	ChangeState(current_state.HandleInput(_event))

func Initialized() -> void:
	state_list = []
	for child in get_children():
		if child is State:
			child.entity = entity
			state_list.append(child)
	if state_list.size() > 0:
		ChangeState(state_list[0])
		process_mode = Node.PROCESS_MODE_INHERIT
		
func ChangeState(new_state : State) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state: 
		current_state.Exit()
		
	previous_state = current_state
	current_state = new_state
	
	current_state.Enter()
	






	
