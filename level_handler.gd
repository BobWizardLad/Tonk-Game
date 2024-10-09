extends Node2D

@onready var decay_timer: Timer = $Timer

@export var current_map: TileMapLayer
@export var warning_texture: CompressedTexture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	fade_tile(current_map)
