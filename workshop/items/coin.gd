class_name Coin extends Area3D

signal collected()
var begin_collected = false
var time_collected_started = 0.0
@onready var animation: AnimatedSprite3D = $AnimatedSprite3D
@onready var collision: CollisionShape3D = $CollisionShape3D

@onready var AnimationScaleDefault = $AnimatedSprite3D.scale
@onready var CollisionScaleDefault = $CollisionShape3D.scale

@onready var disappear_mark: Marker3D = $VFX/Disappear
var disappear_vfx_scn = preload("res://vfx/vfx_coin_disappear.tscn")

func _ready() -> void:
	animation.play("default")
	body_entered.connect(_on_body_entered)

func _process(_delta: float) -> void:
	if begin_collected:
		animation.scale *= 0.98
	if begin_collected && Time.get_ticks_msec() - time_collected_started > 3000:
		Respawn()

func Respawn() -> void:
	time_collected_started = 0
	collision.set_deferred("disabled", false)
	animation.scale = AnimationScaleDefault
	begin_collected = false
	
func _on_body_entered(_body: Node3D) -> void:
	time_collected_started = Time.get_ticks_msec()
	collision.set_deferred("disabled",true)
	begin_collected = true
	collected.emit()
	spawn_vfx_disappear()
	$Coin.play()
	pass
func spawn_vfx_disappear() -> void:
	var vfx = disappear_vfx_scn.instantiate()
	get_tree().current_scene.add_child(vfx)
	vfx.global_transform = disappear_mark.global_transform
