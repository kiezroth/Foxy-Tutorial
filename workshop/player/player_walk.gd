class_name State_walk extends State

@onready var jump: State = $"../Jump"
@onready var idle: Node = $"../Idle"

func _ready() -> void:
	pass 
	
func Enter() -> void:
	entity.animation.play("walk")
	pass
	
func Process(_delta: float) -> State:
	if entity.velocity.x == 0 :
		return idle
		
	if !entity.is_on_floor() : 
		return jump
	return null
	
func Physics(_delta: float) -> State:
	return null
	
	
func HandleInput(_event: InputEvent) -> State:
	return null
	
func Exit() -> void:
	pass
