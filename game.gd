extends Node2D

@export var PLAYER: CharacterBody2D
@export var LEVELHANDLER: LevelHandler

var score: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if LEVELHANDLER.is_current_map_cell_exist(LEVELHANDLER.get_cell_local_to_map(PLAYER.position)):
		pass

func increase_score():
	score += 1
