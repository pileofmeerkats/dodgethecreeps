extends Node


export (PackedScene) var Mob


var score


onready var mobTimer = $MobTimer
onready var scoreTimer = $ScoreTimer
onready var startTimer = $StartTimer
onready var player = $Player
onready var startPosition = $StartPosition
onready var spawnLocation = $MobPath/MobSpawnLocation
onready var hud = $HUD
onready var gameOverSound = $GameOverSound
onready var music =$Music

func _ready():
	randomize()


func _on_Player_hit():
	game_over()


func game_over():
	mobTimer.stop()
	scoreTimer.stop()
	get_tree().call_group( 'Mob', 'queue_free' )
	#get_tree().get_nodes_in_group( 'Mob' )
	
	hud.show_game_over()
	music.stop()
	gameOverSound.play()
	


func new_game():
	score = 0
	player.start( startPosition.position )
	
	hud.update_score( score )
	hud.show_message( 'Get ready!' )
	
	startTimer.start()
	music.play()
	


func _on_MobTimer_timeout():
	spawnLocation.offset = randi()
	
	var mob = Mob.instance()
	add_child( mob )
	
	var direction = spawnLocation.rotation + PI / 2
	direction += rand_range( - PI / 4, PI / 4 )
	
	mob.position = spawnLocation.position
	mob.rotation = direction
	
	mob.linear_velocity = Vector2( rand_range( mob.min_speed, mob.max_speed ), 0 )
	mob.linear_velocity = mob.linear_velocity.rotated( direction )


func _on_ScoreTimer_timeout():
	score += 1
	hud.update_score( score )


func _on_StartTimer_timeout():
	mobTimer.start()
	scoreTimer.start()
