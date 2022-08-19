extends Node2D

export var current_wave = 1
export var enemies_left_in_wave: int = 10
export var wave_increment_amount: int = 5

onready var spawn_points = $SpawnPoints
onready var spawn_timer = $EnemySpawnTimer
onready var rest_label = $UI/Rest

onready var enemy1 = preload("res://Enemies/Blue Enemy.tscn")

var enemies_in_last_wave: int
var player_near_ship = true
var wave_ended = false
var current_day = 1

func _ready():
	enemies_in_last_wave = enemies_left_in_wave

#-270 -160

func _physics_process(delta):
	if get_node("Enemies").get_child_count() <= 0 and enemies_left_in_wave <= 0:
		wave_ended = true
		rest_label.show()
		if player_near_ship and Input.is_action_pressed("shoot"):
			$UI/AnimationPlayer.play("FadeToBlack")
			current_day += 1
			$UI/CurrentDayNumber.text = str(current_day)
			rest_label.hide()
			# show upgrade menu and play animation after going to sleep animation
			enemies_left_in_wave = enemies_in_last_wave + wave_increment_amount
			if spawn_timer.wait_time >= 1:
				spawn_timer.wait_time -= .5
			
			spawn_timer.start()

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

func _on_PlayerDetector_area_entered(area):
	if area.get_parent().name == "Player":
		player_near_ship = true
		print("player near ship")


func _on_PlayerDetector_area_exited(area):
	if area.get_parent().name == "Player":
		player_near_ship = false
		print("player away from ship")


func _on_AnimationPlayer_animation_finished(anim_name):
	wave_ended = false
