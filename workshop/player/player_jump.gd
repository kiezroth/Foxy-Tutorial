class_name State_jump extends State


@onready var idle: Node = $"../Idle"
@onready var walk: Node = $"../Walk"

@onready var jump_mark: Marker3D = $"../../VFX/Jump"

var jump_vfx_scn = preload("res://vfx/vfx_jump.tscn")

func _ready() -> void:
	pass 

func Enter() -> void:
	entity.animation.play("jump")
	# Player falling, no jump vfx
	if entity.previous_position.y <= entity.position.y:
		spawn_vfx_jump()
	pass
	
func Process(_delta: float) -> State:
	if entity.is_on_floor():
		return idle
	return null
	
func Physics(_delta: float) -> State:
	return null
	
	
func HandleInput(_event: InputEvent) -> State:
	return null
	
func Exit() -> void:
	pass
	
func spawn_vfx_jump() -> void:
	var vfx = jump_vfx_scn.instantiate()
	get_tree().current_scene.add_child(vfx)
	vfx.global_transform = jump_mark.global_transform
