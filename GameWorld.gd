extends StaticBody2D

export var player_speed : int = 60

onready var pivot = $Pivot
onready var player = $Pivot/Player
onready var player_gun = $Pivot/Player/Gun

onready var bullet = preload("res://Player/Bullet.tscn")

func _ready():
	player.play("Ready")

func _physics_process(delta):
	if Input.is_action_pressed("move_left"):
		move_left(delta)
	elif Input.is_action_pressed("move_right"):
		move_right(delta)
	else:
		if $Pivot/Player/ReadyTimer.is_stopped():
			player.play("Idle")
	
	if Input.is_action_just_pressed("shoot"):
		var this_bullet = bullet.instance()
		get_node("Bullets").add_child(this_bullet)
		this_bullet.global_position = player_gun.global_position
		
		if player.flip_h == true:
			this_bullet.bullet_speed *= -1
		


func move_left(delta):
	pivot.rotation_degrees -= player_speed * delta
	player.flip_h = true
	player.play("Walk")

func move_right(delta):
	pivot.rotation_degrees += player_speed * delta
	player.flip_h = false
	player.play("Walk")


#-270 -160
