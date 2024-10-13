extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_play_button_down() -> void:
	$MainMenu.hide()
	$Game.show()
	$Game.game_active = true

func _on_local_high_score_button_down() -> void:
	pass

func _on_exit_button_down() -> void:
	get_tree().quit()

func _on_replay_button_down() -> void:
	pass

func _on_back_to_menu_button_down() -> void:
	$GameOver.hide()
	$Game.hide()
	$MainMenu.show()

func _on_player_player_died() -> void:
	$GameOver.show()
	$GameOver/VBoxContainer/Score.text = str(GameState.score)
