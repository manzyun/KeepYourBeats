extends Node

signal set_bpm

var click_count
var first_click_time
var fourth_click_time
var time

func _ready():
	time = 0
	click_count = 0

func _process(delta):
	delta_time(delta)

func delta_time(delta):
	time += delta

func click():
	click_count += 1
	if click_count == 1:
		first_click_time = get_time()
	elif click_count == 4:
		fourth_click_time = get_time()
		fourth_clicked()

func get_time():
	return time
	
func fourth_clicked():
	var delta_time = fourth_click_time - first_click_time
	emit_signal("set_bpm", delta_time)
	set_process(false)
