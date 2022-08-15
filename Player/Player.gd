extends AnimatedSprite

export var player_speed : int = 60

onready var pivot = get_parent()
onready var player_start_timer = $ReadyTimer
onready var player_gun = $Gun

onready var bullet = preload("res://Player/Bullet.tscn")

func _ready():
	play("Ready")

func _process(delta):
	if flip_h:
		player_gun.position.x = -7.75
	else:
		player_gun.position.x = 7.75

func _physics_process(delta):
	if Input.is_action_pressed("move_left"):
		move_left(delta)
	elif Input.is_action_pressed("move_right"):
		move_right(delta)
	else:
		if player_start_timer.is_stopped():
			play("Idle")
	
	if Input.is_action_just_pressed("shoot"):
		var this_bullet = bullet.instance()
		get_parent().get_parent().get_node("Bullets").add_child(this_bullet)
		this_bullet.global_position = player_gun.global_position
		
		if flip_h == true:
			this_bullet.bullet_speed *= -1
		

func move_left(delta):
	pivot.rotation_degrees -= player_speed * delta
	flip_h = true
	play("Walk")

func move_right(delta):
	pivot.rotation_degrees += player_speed * delta
	flip_h = false
	play("Walk")
