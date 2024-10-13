extends Node2D

@export var PLAYER: CharacterBody2D
@export var LEVELHANDLER: LevelHandler
@export var SCORE: Label

var save_filepath = "res://highscores.json"
var scores: Array

var decay_state: bool
var game_end: bool

signal player_died

func _on_tree_entered() -> void:
	player_died.connect(get_parent()._on_player_game_over)

# Reset score, load the player into a random tile, and start decay tiles.
func _ready() -> void:
	# Assumed safe state for global score to reset
	GameState.score = 0
	decay_state = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	SCORE.text = str(GameState.score)
	
	# NOT! If the decay timer exists and is running
	if not game_end && not decay_state:
		LEVELHANDLER.fade_tile()
		decay_state = true
	
	if not game_end && not LEVELHANDLER.is_current_map_cell_exist(LEVELHANDLER.get_cell_local_to_map(PLAYER.position)):
		PLAYER.queue_free()
		emit_signal("player_died")
		game_end = true

func increase_score():
	GameState.score += 1

func _on_level_handler_tile_removed() -> void:
	increase_score()
	decay_state = false
