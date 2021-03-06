extends Node2D

var sin_radius
var cos_radius
var x

func _ready():
	x = 0
	sin_radius = 80.0
	cos_radius = 65.0

func _process(delta):
	sin_radius = 80.0 + 2200.0 * sin(x/16) * delta
	cos_radius = 65.0 + 2000.0 * cos(x/8) * delta
	update()
	x += PI/16.0
	if (x >= 2 * PI) or (x <= -2 * PI):
		x * -1

func _draw():
	var center = Vector2(200, 200)
	draw_circle(center, sin_radius, Color.FOREST_GREEN)
	draw_circle(center, cos_radius, Color.CHARTREUSE)

