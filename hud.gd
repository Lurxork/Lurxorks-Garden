extends CanvasLayer

signal start_game


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Curtain.play("idle")


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("GAME OVER...")
	await $MessageTimer.timeout
	$Message.text = "LURXORK'S\nGARDEN"
	$Message.show()
	$CurtainClose.show()
	$CurtainClose.play("curtain_close")
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$Curtain.show()
	$Curtain.play("idle")
	$CurtainClose.hide()
	$VersionLabel.show()


func update_score(score):
	$ScorLabel.text = str(score)
	


func _on_message_timer_timeout() -> void:
	$Message.hide()


func _on_start_button_released() -> void:
	$StartButton.hide()
	$Curtain.play("curtain_open")


func _on_curtain_animation_finished():
		$Curtain.hide()
		$VersionLabel.hide()
		start_game.emit()
