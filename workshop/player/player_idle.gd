class_name State_idle extends State

@onready var walk: State = $"../Walk"
@onready var jump: State = $"../Jump"

func _ready() -> void:
	pass 
	
func Enter() -> void:
	entity.animation.play("idle")
	pass
	
func Process(_delta: float) -> State:
	if entity.velocity.x != 0 :
		return walk
	if !entity.is_on_floor() : 
		return jump
	return null
	
func Physics(_delta: float) -> State:
	return null
	
	
func HandleInput(_event: InputEvent) -> State:
	return null
	
func Exit() -> void:
	pass
