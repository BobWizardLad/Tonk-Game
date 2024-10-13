extends Node2D
class_name LevelHandler

@onready var decay_timer: Timer = $Timer

@export var current_map: TileMapLayer
@export var warning_texture: AtlasTexture

var will_remove_tiles: bool = true
var DECAY_TIME: float = 3.00
var decay_speed: float = DECAY_TIME
var cell_coord: Vector2i

signal tile_removed

func get_cell_local_to_map(coord: Vector2) -> Vector2i:
	return current_map.local_to_map(coord)

func _process(_delta):
	if current_map.get_used_cells().size() < 15:
		decay_speed = DECAY_TIME * 0.4
	elif current_map.get_used_cells().size() < 30:
		decay_speed = DECAY_TIME * 0.6
	elif current_map.get_used_cells().size() < 50:
		decay_speed = DECAY_TIME * 0.8

func is_current_map_cell_exist(coord: Vector2i) -> bool:
	if current_map.get_cell_source_id(coord) != -1:
		return true
	if current_map.get_cell_source_id(coord) == -1:
		return false
	else:
		return false

# Function to make random tiles on the map fade to black
func fade_tile(tileset: TileMapLayer):
	cell_coord = tileset.get_used_cells()[randi_range(0, tileset.get_used_cells().size()-1)]
	var tween = get_tree().create_tween()
	var warn = Sprite2D.new()
	warn.modulate = Color(1.0, 1.0, 1.0, 0.0)
	warn.texture = warning_texture
	warn.position = current_map.map_to_local(cell_coord)
	add_child(warn)
	tween.tween_property(warn, "modulate", Color(1.0, 1.0, 1.0, 1.0), decay_speed * 0.8)
	tween.tween_callback(remove_tile.bind(tileset, cell_coord, warn))

func remove_tile(tileset: TileMapLayer, tile_coord: Vector2i, warning: Sprite2D):
	warning.queue_free()
	tileset.erase_cell(tile_coord)
	emit_signal("tile_removed")

func _on_timer_timeout() -> void:
	decay_timer.wait_time = decay_speed
	if current_map.get_used_cells().size() > 0 and will_remove_tiles:
		fade_tile(current_map)
