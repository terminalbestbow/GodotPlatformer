extends Area2D

@onready var ray = $LOSChecker
@onready var r_cone = $RCone
@onready var l_cone = $LCone
@onready var line_2d = $RCone/Line2D
@onready var line_2d2 = $LOSChecker/Line2D

var inArea = false
var sight = 100
var pos
var Player
var targetMask
var rvectors

signal ray_colliding

# Called when the node enters the scene tree for the first time.
func _ready():
	rvectors = r_cone.polygon
	ray.target_position = Vector2(0, 0)
	line_2d.points = rvectors

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rvectors = r_cone.polygon
	line_2d.points = rvectors
	ray.force_raycast_update()
	if Player != null and inArea:
		ray.target_position = Player.position - ray.global_position
		line_2d2.points.clear()
		line_2d2.points[0] = line_2d2.position
		line_2d2.points[1] = ray.target_position
		if ray.is_colliding() and ray.get_collider() == Player:
			print(ray.get_collider())
			ray_colliding.emit(Player.position - ray.global_position)


func _on_body_entered(body):
	Player = body
	print("Area entered")
	inArea = true
	pos = body.position
	ray.target_position = pos


func _on_body_exited(body):
	ray.target_position = Vector2(0, 0)
	print("Area left")
	inArea = false

func rotateRay(rotation):
	var i = 1
	r_cone.polygon[i].x = r_cone.polygon[i].x * cos(rotation) - r_cone.polygon[i].y * sin(rotation)
	r_cone.polygon[i].y = r_cone.polygon[i].x * sin(rotation) + r_cone.polygon[i].y * cos(rotation)
	i = 2
	rotation = -rotation
	r_cone.polygon[i].x = r_cone.polygon[i].x * cos(rotation) - r_cone.polygon[i].y * sin(rotation)
	r_cone.polygon[i].y = r_cone.polygon[i].x * sin(rotation) + r_cone.polygon[i].y * cos(rotation)
