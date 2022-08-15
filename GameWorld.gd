extends StaticBody2D

export var player_speed : int = 60

onready var pivot = $Pivot
onready var player = $Pivot/Player

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		move_left(delta)
	elif Input.is_action_pressed("ui_right"):
		move_right(delta)
	else:
		player.play("Idle")


func move_left(delta):
	pivot.rotation_degrees -= player_speed * delta
	player.flip_h = true
	player.play("Walk")

func move_right(delta):
	pivot.rotation_degrees += player_speed * delta
	player.flip_h = false
	player.play("Walk")


#-270 -160
