extends Node2D

@export var PLAYER: CharacterBody2D
@export var LEVELHANDLER: LevelHandler
@export var SCORE: Label

var save_filepath = "res://highscores.json"
var scores: Array

var game_active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	SCORE.text = str(GameState.score)
	
	LEVELHANDLER.will_remove_tiles = game_active
	if game_active:
		if not LEVELHANDLER.is_current_map_cell_exist(LEVELHANDLER.get_cell_local_to_map(PLAYER.position)):
			PLAYER.queue_free()
			PLAYER.emit_signal("player_died")
			game_active = false

func increase_score():
	GameState.score += 1

func _on_level_handler_tile_removed() -> void:
	increase_score()
