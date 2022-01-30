extends Area2D

signal clicked

@export var speed = 400

var velocity

func init(direction):
	velocity = Vector2(randf_range(150.0, 250.0), 0.0).rotated(direction)

func _ready():
	$AnimatedSprite2D.playing = true
	var mob_types = $AnimatedSprite2D.frames.get_animation_names()
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_note_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("clicked", position)
			queue_free()

func _process(delta):
	position += velocity * delta
