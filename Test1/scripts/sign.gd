extends Area2D

var inArea = false
@onready var text = $Text
@onready var timer = $Timer

func _ready():
	text.hide()

func _on_body_entered(body):
	inArea = true

func _on_body_exited(body):
	inArea = false
	if text.visible:
		timer.start()

func _process(delta):
	if Input.is_action_just_pressed("interact") and inArea and !text.visible:
		text.show()


func _on_timer_timeout():
	text.hide()
