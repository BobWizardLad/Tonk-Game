extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_play_button_down() -> void:
	$MainMenu.hide()
	$Game.show()

func _on_local_high_score_button_down() -> void:
	pass

func _on_exit_button_down() -> void:
	get_tree().quit()
