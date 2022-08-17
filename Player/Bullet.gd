extends KinematicBody2D

export var bullet_speed = 600

var velocity = Vector2.ZERO

func _physics_process(delta):
	
	#can use collision_info to detect collisions with the bullet
	var collision_info = move_and_collide(velocity.normalized() * delta * bullet_speed)
	
	
	if $Lifetime.is_stopped():
		queue_free()


func _on_EnemyDetector_area_entered(area):
	if area.get_parent().is_in_group("ignore_bullets"):
		pass
	else:
		queue_free()
