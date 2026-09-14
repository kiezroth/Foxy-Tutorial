extends Node3D
@onready var coins: Node3D = $Coins
@onready var player: Player = $Player

func _init() -> void:
	pass
func _process(_delta: float) -> void:
	pass
func _physics_process(_delta: float) -> void:
	if player.position.y < -10:
		player.position = Vector3(7,20,3)
		player.velocity.y = -10
	pass
func _ready() -> void:
	print("Hi, I'm ready")
	create_palm_tree(4,4,2,1.2,false,0)
	create_palm_tree(0,4,6,1, true,10)
	for c in coins.get_children():
		if c is Coin:
			c.collected.connect($Player.add_coin)
	pass
func create_palm_tree(x,y,z,Sscale:float, flip_h : bool, degskew : int) -> void:
	var sprite3d = Sprite3D.new()
	sprite3d.texture = load("res://assets/terrain/palm_tree.png")
	sprite3d.pixel_size = 0.0625
	sprite3d.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	sprite3d.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	sprite3d.alpha_cut = BaseMaterial3D.ALPHA_ANTIALIASING_OFF
	sprite3d.position = Vector3(x, y, z)
	sprite3d.scale *= Sscale
	sprite3d.flip_h = flip_h
	if degskew != 0: 
		sprite3d.billboard = BaseMaterial3D.BILLBOARD_DISABLED
	sprite3d.rotate_x(deg_to_rad(degskew))
	add_child(sprite3d)
	pass



# MSSV: 24521042
