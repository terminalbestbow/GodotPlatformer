extends CharacterBody2D

@onready var cone = $LOSCone
@onready var timer = $chaseTimer
@onready var anim = $AnimatedSprite2D

var chasing = false
var direction
var startPos
var speed = 1
var firstturn = true
# Called when the node enters the scene tree for the first time.
func _ready():
	cone.sight = 1000
	startPos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2(0,0)
	if chasing:
		speed = 1.5
		move_and_collide(direction * delta * speed)
	elif !chasing and position != startPos:
		direction = startPos - global_position
		move_and_collide(direction * delta * speed)

func _on_los_cone_ray_colliding(pos):
	timer.start()
	direction = pos
	chasing = true



func _on_timer_timeout():
	chasing = false
	speed = 0.3


func _on_look_timer_timeout():
	if !chasing:
		if anim.flip_h:
			anim.set_flip_h(false)
		else:
			anim.set_flip_h(true)
		cone.rotateRay(PI/2)
	
