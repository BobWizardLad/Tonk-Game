extends Control

@export var play_again_button: Button
@export var to_menu_button: Button
@export var score_label: Label

func _on_tree_entered() -> void:
	play_again_button.pressed.connect(get_parent()._on_play_again)
	to_menu_button.pressed.connect(get_parent()._on_back_to_menu)

func _ready():
	score_label.text = str(GameState.score)
