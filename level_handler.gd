extends Node2D
class_name LevelHandler

@onready var decay_timer: Timer = $Timer

@export var current_map: TileMapLayer
@export var warning_texture: AtlasTexture

func get_cell_local_to_map(coord: Vector2) -> Vector2i:
	return current_map.local_to_map(coord)

func is_current_map_cell_exist(coord: Vector2i) -> bool:
	if current_map.get_cell_source_id(coord) != -1:
		return true
	if current_map.get_cell_source_id(coord) == -1:
		return false
	else:
		return false

# Function to make random tiles on the map fade to black
func fade_tile(tileset: TileMapLayer):
	var cell_coord = tileset.get_used_cells()[randi_range(0, tileset.get_used_cells().size()-1)]
	var tween = get_tree().create_tween()
	var warn = Sprite2D.new()
	warn.modulate = Color(1.0, 1.0, 1.0, 0.0)
	warn.texture = warning_texture
	warn.position = current_map.map_to_local(cell_coord)
	add_child(warn)
	tween.tween_property(warn, "modulate", Color(1.0, 1.0, 1.0, 1.0), 1.0)
	tween.tween_callback(remove_tile.bind(tileset, cell_coord, warn))

func remove_tile(tileset: TileMapLayer, tile_coord: Vector2i, warning: Sprite2D):
	warning.queue_free()
	tileset.erase_cell(tile_coord)

func _on_timer_timeout() -> void:
	if current_map.get_used_cells().size() > 0:
		fade_tile(current_map)
