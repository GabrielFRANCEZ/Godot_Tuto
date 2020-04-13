extends RigidBody2D

export var min_speed = 150
export var max_speed = 250
var mob_type = ["walk", "swim", "fly"]

func _ready():
	$AnimatedSprite.animation = mob_type[randi() % mob_type.size()]


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func _on_start_game():
	queue_free()

func _on_Visibility_screen_exited():
	queue_free()
