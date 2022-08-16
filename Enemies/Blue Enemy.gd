extends Area2D

export var health: int = 2

onready var moon_center = get_parent().get_parent().get_node("Pivot")

onready var power_up = preload("res://Effects/PowerUp.tscn")
onready var explosion = preload("res://Effects/Explosion/Explosion.tscn")


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	look_at(moon_center.global_position)

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
	
	area.get_parent().queue_free()
