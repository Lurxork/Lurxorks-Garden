extends Node

@export var mob_scene: PackedScene
@export var fly_mob_scene: PackedScene
var score
var mob_score = int(0)
var try_spawn


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$FlyMobTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	get_tree().call_group("mobs", "queue_free")
	$HUD.show_message(" ")
	await get_tree().create_timer(1.5).timeout
	$StartTimer.start()
	$HUD.show_message("EVADE THE BUGS")

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var velocity = Vector2(0.0 , 0.0)
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	var direction = mob_spawn_location.rotation + PI/2
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	#if score > 100 && mob_score % 5:
		#velocity = Vector2(randf_range(50.0, 150.0), 0.0)
	#else: 
	velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)

func _on_fly_mob_timer_timeout() -> void:
	var mob = fly_mob_scene.instantiate()
	var velocity = Vector2(0.0 , 0.0)
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	var direction = mob_spawn_location.rotation + PI/2
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	#if mob_score % 3 && score > 75:
		#velocity = Vector2(800, 0.0)
	#else:
	velocity = Vector2(randf_range(250.0, 450.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	mob_score = mob_score + randi_range(1, 3)
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	$FlyMobTimer.start()
