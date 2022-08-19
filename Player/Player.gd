extends AnimatedSprite

#can be spent to upgrade your moon health(make moon bigger?), add a turret to a predefined set of locations if there is one left,         boot upgrade for speed?  

export var player_speed : int = 60

var power: int = 0

onready var pivot = get_parent()
onready var player_start_timer = $ReadyTimer
onready var player_gun = $Gun
onready var shoot_delay_timer = $ShootDelay
onready var energy_label = get_parent().get_parent().get_node("UI/CurrentEnergy")

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
			if Input.is_action_pressed("shoot"):
				pass
			else:
				play("Idle")
	
	if Input.is_action_pressed("shoot"):
		if get_parent().get_parent().wave_ended == true:
			pass 
		elif shoot_delay_timer.is_stopped():
			shoot_delay_timer.start()
			play("Shoot")
			var this_bullet = bullet.instance()
			get_parent().get_parent().get_node("Bullets").add_child(this_bullet)
			this_bullet.global_position = player_gun.global_position
			
			if flip_h == true:
				this_bullet.bullet_speed *= -1
			
			
			this_bullet.velocity = $ShootDirection.global_position - player_gun.global_position
			this_bullet.look_at($ShootDirection.global_position)

func move_left(delta):
	pivot.rotation_degrees -= player_speed * delta
	flip_h = true
	play("Walk")
	

func move_right(delta):
	pivot.rotation_degrees += player_speed * delta
	flip_h = false
	play("Walk")

func increase_power():
	power += 1
	energy_label.text = str(power)

