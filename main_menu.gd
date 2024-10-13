extends Control

@export var play_button: Button
@export var HS_button: Button
@export var exit_button: Button

func _on_tree_entered() -> void:
	play_button.pressed.connect(get_parent()._on_play_button_pressed)

func _on_exit_pressed() -> void:
	get_tree().quit()
