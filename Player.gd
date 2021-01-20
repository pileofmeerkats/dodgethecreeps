extends Area2D


signal hit


export var speed = 40
export var acceleration = 80
export var friction = 60


var screen_size
var velocity = Vector2.ZERO


onready var animatedSprite = $AnimatedSprite
onready var collision = $CollisionShape2D


func _ready():
	screen_size = get_viewport_rect().size
	hide()


func _process( delta ):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength( "p_right" ) - Input.get_action_strength( "p_left" )
	input_vector.y = Input.get_action_strength( "p_down" ) - Input.get_action_strength( "p_up" )
	
	input_vector = input_vector.normalized()
	
	if( input_vector != Vector2.ZERO ):
		velocity = velocity.move_toward( input_vector * speed, delta * acceleration )
		animatedSprite.play( 'walk' )
	else:
		velocity = velocity.move_toward( Vector2.ZERO, delta * friction )
		animatedSprite.play( 'up' )
	
	if( input_vector.x < 0 ):
		animatedSprite.flip_h = true
	else:
		animatedSprite.flip_h = false
	
	position.x += velocity.x
	position.y += velocity.y

	position.x = clamp( position.x, 0, screen_size.x )
	position.y = clamp( position.y, 0, screen_size.y )


func start( pos ):
	position = pos
	show()
	collision.disabled = false
	print( 'player start' )


func _on_Player_body_entered(body):
	hide()
	emit_signal( "hit" )
	collision.set_deferred( 'disabled', true )
	
	print( 'hit' )
