extends Node

@export var note_scene: PackedScene
@export var particles_scene: PackedScene
var score
var attend_score
var clear_score = 2022

func _ready():
	randomize()

func new_game():
	score = 0
	attend_score = 1
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func game_clear():
	$ScoreTimer.stop()
	$NoteTimer.stop()
	$HUD.show_game_clear()
	score = 2022
	get_tree().call_group("notes", "queue_free")

func _on_ScoreTimer_timeout():
	score += attend_score
	if score >= clear_score:
		game_clear()
	$HUD.update_score(score)
	
func click_note(position):
	var particle = particles_scene.instantiate()
	add_child(particle)
	particle.position = position
	particle.explosion()
	attend_score += 1

func _on_StartTimer_timeout():
	$NoteTimer.start()
	$ScoreTimer.start()

func _on_note_timer_timeout():
	var note_spawn_location = get_node("NotePath/NoteSpawnLocation");
	note_spawn_location.offset = randi()
	
	var note = note_scene.instantiate()
	add_child(note)
	
	var direction = note_spawn_location.rotation + PI/2
	
	note.position = note_spawn_location.position
	
	direction += randf_range(-PI/4,PI/4)
	note.rotation = direction
	
	note.init(direction)
	note.connect("clicked", click_note)

