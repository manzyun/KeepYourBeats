extends CanvasLayer

signal start_game

func _ready():
	hide_credit()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_credit():
	$Credit/Title.show()
	$Credit/Text.show()
	
func hide_credit():
	$Credit/Title.hide()
	$Credit/Text.hide()

func show_game_clear():
	show_message("Game Clear")
	await $MessageTimer.timeout
	
	show_credit()
	$MessageTimer.start()
	await $MessageTimer.timeout
	hide_credit()
	
	$Message.text = "Clicker"
	$Message.show()
	
	await get_tree().create_timer(1).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_message_timer_timeout():
	$Message.hide()
	
func _on_start_button_pressed():
	$StartButton.hide()
	emit_signal("start_game")
