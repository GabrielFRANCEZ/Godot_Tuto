extends Area2D
signal hit 

export var speed = 400 #How fast the player will move
var screen_size #Size of the game window
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	screen_size = get_viewport().size
	hide()


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0 :
		velocity = velocity.normalized() * speed 
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation="right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0 
	if velocity.y != 0:
		$AnimatedSprite.animation="up"
		$AnimatedSprite.flip_v = velocity.y > 0 
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Player_body_entered(body):
	hide() #Player disappears after being hit
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
