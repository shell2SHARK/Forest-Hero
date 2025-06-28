extends Node

@export var initialState : State
var states : Dictionary = {}
var actualState : State

# Coleta todos os states dentro do State Machine como filhos
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.changed_state.connect(set_new_state)
	
	# Se existe um initial state, chama ele
	if initialState:
		initialState.enter()
		actualState = initialState

# Seta process e e physics_process aos states de processamento
func _process(delta: float) -> void:
	if actualState:
		actualState.update(delta)

func _physics_process(delta: float) -> void:
	if actualState:
		actualState.physics_update(delta)

func set_new_state(state, new_state):
	# Se o state for diferente do atual
	if state != actualState: 
		return
	
	# Coleta o novo state
	var getNewState = states.get(new_state) 
	if !getNewState:
		return
	
	# Se temos um state atual, chama exit pra ele
	if actualState:
		actualState.exit()
	
	# E adiciona o novo state
	getNewState.enter()
	actualState = getNewState
	
