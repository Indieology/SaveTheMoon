extends AnimatedSprite


func _process(delta):
	if flip_h:
		$Gun.position.x = -7.75
	else:
		$Gun.position.x = 7.75
