extends RigidBody2D


export var min_speed = 150
export var max_speed = 250


onready var animatedSprite = $AnimatedSprite


func _ready():
	var mob_animations = animatedSprite.frames.get_animation_names()
	animatedSprite.animation = mob_animations[randi() % mob_animations.size()]
	add_to_group( 'Mob' )


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
