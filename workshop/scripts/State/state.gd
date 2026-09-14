##Abstract
class_name State extends Node

var entity

func _ready() -> void:
	pass 
	
## Hoạt động trong _physics_process
func Physics(_delta: float) -> State:
	return null
	
## Hoạt động trong _process
func Process(_delta: float) -> State:
	return null

## Hoạt động trong _unhandled_input
func HandleInput(_event: InputEvent) -> State:
	return null

## Vào state
func Enter() -> void:
	pass
	
## Thoát state
func Exit() -> void:
	pass
	
