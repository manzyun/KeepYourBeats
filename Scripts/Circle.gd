extends Node2D

var radius

func _ready():
	radius = 80.0

func _process(delta):
	radius += 2.0 * delta
	update()

func _draw():
	var center = Vector2(200, 200)
	draw_circle(center, radius, Color.AQUA)
	draw_circle(center, radius - 5, Color.BLACK)

