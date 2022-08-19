extends Area2D

export var health: int = 2
export var ship_speed: int = 100
onready var moon_center = get_parent().get_parent().get_node("Pivot")

onready var power_up = preload("res://Effects/PowerUp.tscn")
onready var explosion = preload("res://Effects/Explosion/Explosion.tscn")
onready var bullet = preload("res://Player/Bullet.tscn")

var velocity = Vector2.ZERO

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	look_at(moon_center.global_position)
	velocity = global_position.direction_to(moon_center.global_position)
	if global_position.distance_to(moon_center.global_position) > 280:
		global_position += velocity * ship_speed * delta
	else:
		if $ShootTimer.is_stopped():
			var this_bullet = bullet.instance()
			get_parent().get_parent().get_node("Bullets").add_child(this_bullet)
			this_bullet.global_position = $GunLocation.global_position
			this_bullet.look_at(moon_center.global_position)
			this_bullet.velocity = moon_center.global_position - $GunLocation.global_position
			$ShootTimer.start()
func _on_Blue_Enemy_area_entered(area):
	health -= 1
	if health <= 0:
		var this_power_up = power_up.instance()
		get_parent().get_parent().get_node("PowerUps").call_deferred("add_child", this_power_up)
		this_power_up.call_deferred("set_start_position", global_position)
		
		var this_explosion = explosion.instance()
		get_parent().get_parent().call_deferred("add_child", this_explosion)
		this_explosion.call_deferred("set_start_position", global_position)
		queue_free()
	
