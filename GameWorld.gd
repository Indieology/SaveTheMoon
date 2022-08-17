extends Node2D

export var current_wave = 1
export var enemies_left_in_wave: int = 10

onready var spawn_points = $SpawnPoints
onready var spawn_timer = $EnemySpawnTimer

onready var enemy1 = preload("res://Enemies/Blue Enemy.tscn")

func _ready():
	pass

#-270 -160


func _on_EnemySpawnTimer_timeout():
	#select random spawn point
	var last_enemy_spawn_location = 1
	if enemies_left_in_wave > 0:
		randomize()
		var random_point = rand_range(1, spawn_points.get_child_count())
		if random_point == last_enemy_spawn_location:
			_on_EnemySpawnTimer_timeout()
		else:
			last_enemy_spawn_location = random_point
			var this_random_point = spawn_points.get_child(random_point)
		
			var this_enemy = enemy1.instance()
			get_node("Enemies").add_child(this_enemy)
			this_enemy.global_position = this_random_point.global_position
		
			spawn_timer.start()
			enemies_left_in_wave -= 1

