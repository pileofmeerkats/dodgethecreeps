extends CanvasLayer


signal start_game


onready var message = $Message
onready var messageTimer = $MessageTimer
onready var startButton = $StartButton
onready var scoreLabel = $ScoreLabel

func show_message( text ):
	message.text = text
	message.show()
	messageTimer.start()


func _on_MessageTimer_timeout():
	message.text = ''
	message.hide()


func show_game_over():
	show_message( 'Game Over' )
	yield( messageTimer, 'timeout' )
	
	message.text = 'Dodge the Creeps!'
	message.show()
	
	yield( get_tree().create_timer( 1 ), 'timeout' )
	
	startButton.show()


func update_score( score ):
	scoreLabel.text = str( score )


func _on_StartButton_pressed():
	startButton.hide()
	emit_signal( 'start_game' )
	
