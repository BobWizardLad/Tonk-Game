extends Node2D

@export var current_map: TileMapLayer
@export var warning_texture: CompressedTexture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_tile(current_map)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to make random tiles on the map fade to black
func fade_tile(tileset: TileMapLayer):
	var cell_coord = tileset.get_used_cells()[randi_range(0, tileset.get_used_cells().size()-1)]
	var warn = Sprite2D.new()
	warn.texture = warning_texture
	warn.position = current_map.map_to_local(cell_coord)
	add_child(warn)
	
