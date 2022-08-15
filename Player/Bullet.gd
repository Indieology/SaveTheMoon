extends Area2D

export var bullet_speed = 30

func _physics_process(delta):
	position.x += bullet_speed
	
	if $Lifetime.is_stopped():
		queue_free()
