extends Node

@export var game_scene: PackedScene
var game_session: Node2D
@export var main_menu_scene: PackedScene
var main_menu: Control
@export var game_over_scene: PackedScene
var game_over: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu = main_menu_scene.instantiate()
	add_child(main_menu)

func _on_play_button_pressed():
	game_session = game_scene.instantiate()
	main_menu.hide()
	add_child(game_session)

func _on_player_game_over():
	game_over = game_over_scene.instantiate()
	game_session.queue_free()
	add_child(game_over)
	
func _on_play_again():
	game_session = game_scene.instantiate()
	game_over.queue_free()
	add_child(game_session)

func _on_back_to_menu():
	game_over.queue_free()
	main_menu.show()
