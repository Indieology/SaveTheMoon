extends KinematicBody2D

export var bullet_speed = 500

var velocity = Vector2.ZERO

func _physics_process(delta):
	#position.x += bullet_speed
	#can use collision_info to detect collisions with the bullet
	var collision_info = move_and_collide(velocity.normalized() * delta * bullet_speed)
	
	
	if $Lifetime.is_stopped():
		queue_free()
